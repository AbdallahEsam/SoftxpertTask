//
//  RecipeDetailsModel.swift
//  SoftxpertTask
//
//  Created by Abdallah Essam on 18/08/2022.
//  Copyright © 2022 Abdallah Essam. All rights reserved.
//


import Foundation

// MARK: - RecipeDetails
struct RecipeDetailsModel: Codable {
    let recipe: Recipe?
    let links: Links?

    enum CodingKeys: String, CodingKey {
        case recipe
        case links = "_links"
    }
}


