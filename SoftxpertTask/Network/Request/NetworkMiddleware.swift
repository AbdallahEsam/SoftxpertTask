//
//  NetworkMiddleware.swift
//  VIP Base
//
//  Created by Abdallah Essam on 18/08/2022..
//  Copyright © 2022 Abdallah Essam. All rights reserved.
//


import Foundation
import Alamofire

class RequestAdapterMiddleware: RequestAdapter {
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
//        if let token = AuthService.userData?.token?.accessToken {
//            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//        }
        
        #if DEBUG
        debugPrint("====================******************===================")
        print(urlRequest)
        print(urlRequest.allHTTPHeaderFields!)
        print(urlRequest.method!)
        debugPrint("====================******************===================")
        #endif
        
        completion(.success(urlRequest))
    }
}

class RequestRetrierMiddleware: RequestRetrier {
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        completion(.doNotRetry)
    }
}
