//
//  Localization.swift
//  SoftxpertTask
//
//  Created by Abdallah Essam on 18/08/2022.
//  Copyright © 2022 Abdallah Essam. All rights reserved.
//

import Foundation
struct Localization {
    
    enum LocalizationKey: String {
        
        case cannotDecode = "cannot_decode"
        case noInternet = "no_internet"
        case error401 = "error_401"
        case error500 = "error_500"
        case timeoutError = "timeout_Error"
        case success = "success"
        case warning = "warning"
        case error = "error"
        case sorry = "Oops..! Sorry"
        case noSearch = "no_search_result"
        case searchRecipeTitle = "search_recipe_title"
        case recipeDetailsTitle = "recipe_details_title"
    }
    
    static func string(for key: LocalizationKey) -> String {
        NSLocalizedString(key.rawValue, comment: "")
    }
}

