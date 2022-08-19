//
//  Constant.swift
//  VIP Base
//
//  Created by Abdallah Essam on 18/08/2022.
//  Copyright © 2022 Abdallah Essam. All rights reserved.
//

import Foundation
enum ConstantsEnum {
    static var baseURL: String {
        return Constants.baseUrlKey + "/"
    }
}


struct Constants {
    static let baseUrlKey = "https://api.edamam.com/api/recipes"
    static var responseValid = "true"
    static let appID = "a6808016"
    static let appKey = "31d5f79b1d6899a4d7c550b557c55280"
}
