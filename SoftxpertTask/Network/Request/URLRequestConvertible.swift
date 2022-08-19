//
//  URLRequestConveritble.swift
//  VIP Base
//
//  Created by Abdallah Essam on 18/08/2022..
//  Copyright © 2022 Abdallah Essam. All rights reserved.
//


import Foundation
import Alamofire
typealias params = [String: Any]
protocol URLRequestConvertible: Alamofire.URLRequestConvertible {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var path: String { get }
    var encoding: ParameterEncoding { get }
}

extension URLRequestConvertible {
    var baseURL: String {
        return ConstantsEnum.baseURL
    }
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    func asURLRequest() throws -> URLRequest {
        let stringURL = (baseURL + path).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        var urlRequest = URLRequest(url: URL(string: stringURL)!)
        urlRequest.httpMethod = method.rawValue
        return try encoding.encode(urlRequest, with: parameters)
    }
}
