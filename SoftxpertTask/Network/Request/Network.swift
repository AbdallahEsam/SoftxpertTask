//
//  Network.swift
//  VIP Base
//
//  Created by Abdallah Essam on 18/08/2022..
//  Copyright © 2022 Abdallah Essam. All rights reserved.
//


import Alamofire

typealias NetworkCompletion<T> = (Result<T, AppError>) -> ()

protocol NetworkProtocol {
    func request<T>(_ request: URLRequestConvertible, decodeTo type: T.Type, completionHandler: @escaping NetworkCompletion<T>) where T: Codable
    func upload<T>(_ request: URLRequestConvertible, data: [UploadData], decodedTo type: T.Type, completionHandler: @escaping NetworkCompletion<T>) where T: Codable
    func cancelAllRequests()
}

class Network {
    
    fileprivate let requestRetrierMiddleware = RequestRetrierMiddleware()
    fileprivate let requestAdapterMiddleware = RequestAdapterMiddleware()
    
     lazy var session: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = HTTPHeaders.default.dictionary
        configuration.timeoutIntervalForResource = 60
        configuration.timeoutIntervalForRequest = 60
        let interceptor = Interceptor(adapter: requestAdapterMiddleware, retrier: requestRetrierMiddleware)
        let session = Session(configuration: configuration, interceptor: interceptor)
        return session
    }()
    
    fileprivate func filterError(error:AFError)->AppError{
        
        if let underlyingError = error.underlyingError {
            if let urlError = underlyingError as? URLError {
                switch urlError.code {
                case .timedOut:
                    return .timeOut
                case .notConnectedToInternet:
                    return .noInternet
                default:
                    return .error(error.localizedDescription)
                }
            }
        }
        return .error(error.localizedDescription)
    }
    
    fileprivate func process<T>(response: AFDataResponse<String>, decodedTo type: T.Type) -> (Result<T, AppError>) where T : Codable  {
        
        switch response.result {
        case .success:
            
            switch response.response?.statusCode {
            case 401:
                return .failure(.tokenExpire)
            case 500:
                return .failure(.internalServerError)
            case 200:
                guard let data = response.data  else {
                    return .failure(.internalServerError)
                }
                #if DEBUG
                print("*************$$$$$$$$$*************")
                let json = SwiftyJSON(response.value ?? [:])
                print(json)
                print("*************$$$$$$$$$*************")
                #endif
                
               
                guard let data = try? JSONDecoder.decodeFromData(type, data: data) else {
                    return .failure(.cannotDecode)
                    
                }
                
                return .success(data)
            default:
                guard let data = response.data  else {
                    return .failure(.internalServerError)
                }
                #if DEBUG
                print("*************Error*************")
                let json = SwiftyJSON(response.value ?? [:])
                print(json)
                print("*************$$$$$$$$$*************")
                #endif
                
               
                guard let data = try? JSONDecoder.decodeFromData(ErrorModel.self, data: data) else {
                    return .failure(.cannotDecode)
                    
                }
                
                return .failure(.error(data.message ?? ""))
            }
       
        
            
        case .failure(let error):
            #if DEBUG
            print(error)
            debugPrint("#DEBUG#", error.localizedDescription)
            #endif
            return .failure(filterError(error: error))
        }
    }
    
    
    func cancelAllRequests() {
        session.cancelAllRequests()
    }
}

extension Network: NetworkProtocol {
    func request<T>(_ request: URLRequestConvertible, decodeTo type: T.Type, completionHandler: @escaping NetworkCompletion<T>) where T : Codable {
        #if DEBUG
        print(SwiftyJSON(request.parameters ?? [:]))
        #endif
        session
            .request(request)
            .responseString {[weak self] response in
                guard let self = self else { return }
                completionHandler(self.process(response: response, decodedTo: type))
            }
    }
    
    func upload<T>(_ request: URLRequestConvertible, data: [UploadData], decodedTo type: T.Type, completionHandler: @escaping NetworkCompletion<T>) where T : Codable {
        #if DEBUG
        print(SwiftyJSON(request.parameters ?? [:]))
        #endif
        session
            .upload(multipartFormData: { multipartFormData in
                data.forEach {
                    multipartFormData.append($0.data, withName: $0.name, fileName: $0.fileName, mimeType: $0.mimeType)
                }
                
                for (key, value) in request.parameters ?? [:] {
                    multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                }
            }, with: request)
            .responseString {[weak self] response in
                guard let self = self else { return }
                completionHandler(self.process(response: response, decodedTo: type))
            }
            .uploadProgress { (progress) in
                #if DEBUG
                print(String(format: "%.1f", progress.fractionCompleted * 100))
                #endif
            }
    }
    
    
    
}
