//
//  MainRouters.swift
//  SoftxpertTask
//
//  Created by Abdallah Essam on 18/08/2022.
//  Copyright © 2022 Abdallah Essam. All rights reserved.
//

import Alamofire

enum MainRouters: URLRequestConvertible {
    var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        case .details:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .search(let searchKey, let filter, let from):
            let body: [String: Any?] = [
                "q": searchKey,
                "health": filter?.rawValue,
                "from": from,
                "app_id": Constants.appID,
                "app_key": Constants.appKey,
                "type": "public"
            ]
            
            return body.compactMapValues({$0})
        case .details:
            return ["app_id": Constants.appID,
                    "app_key": Constants.appKey,
                    "type": "public"]
        }
    }
    
    var path: String {
        switch self {
        case .search:
            return "v2"
        case .details(id: let id):
            return "v2/\(id)"
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
      
        default :
            return URLEncoding.default
        }
    }
    
    case search(searchKey: String?, filter: FilterEnum?, from: Int)
    case details(id: String)
    
}
