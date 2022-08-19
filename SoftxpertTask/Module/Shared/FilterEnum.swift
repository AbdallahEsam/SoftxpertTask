//
//  FilterEnum.swift
//  SoftxpertTask
//
//  Created by Abdallah Essam on 18/08/2022.
//  Copyright © 2022 Abdallah Essam. All rights reserved.
//

import Foundation

enum FilterEnum: String, CaseIterable {
    case non
    case lowSugar = "low-sugar"
    case vegan = "vegan"
    case keto = "keto-friendly"
    
    
    var displayName: String {
        switch self {
        case .non:
            return "All"
        case .lowSugar:
            return "Low Sugar"
        case .vegan:
            return "Vegan"
        case .keto:
            return "Keto"
        }
    }
}
