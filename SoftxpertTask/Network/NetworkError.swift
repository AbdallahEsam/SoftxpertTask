//
//  NetworkError.swift
//  VIP Base
//
//  Created by Abdallah Essam on 18/08/2022.
//  Copyright © 2022 Abdallah Essam. All rights reserved.
//

import Foundation
enum AppError: Error, LocalizedError {
    
    init(error: Error) {
        self = .error(error.asAFError?.localizedDescription ?? "error")
    }
    
    
    case cannotDecode // Handle ComminDate
    case noInternet // ---
    case error(String) // Error.Description
    case tokenExpire // 401
    case internalServerError // 500
    case timeOut
    var description: String {
        switch self {
        
        case .cannotDecode:
            return Localization.string(for: .cannotDecode)
        case .noInternet:
            return Localization.string(for: .noInternet)
        case let .error(err):
            return err
        case .tokenExpire:
            return Localization.string(for: .error401)
        case .internalServerError:
            return Localization.string(for: .error500)
        case .timeOut:
            return Localization.string(for: .timeoutError)
        }
    }
}
