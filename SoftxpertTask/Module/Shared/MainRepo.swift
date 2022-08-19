//
//  MainRepo.swift
//  SoftxpertTask
//
//  Created by Abdallah Essam on 18/08/2022.
//  Copyright © 2022 Abdallah Essam. All rights reserved.
//

import Foundation

protocol MainRepoProtocol {
    func search(searchKey: String?, filter: FilterEnum?, from: Int, handler: @escaping  NetworkCompletion<SearchRecipe>)
    func recipeDetails(id: String, handler: @escaping  NetworkCompletion<RecipeDetailsModel>)
}

class MainRepo {
    
     private let network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        
        self.network = network
    }
    
    
}

extension MainRepo: MainRepoProtocol {
    
    func search(searchKey: String?, filter: FilterEnum?, from: Int, handler: @escaping  NetworkCompletion<SearchRecipe>) {
        
        network.request(MainRouters.search(searchKey: searchKey, filter: filter, from: from), decodeTo: SearchRecipe.self, completionHandler: handler)
    }
    
    func recipeDetails(id: String, handler: @escaping  NetworkCompletion<RecipeDetailsModel>) {
        
        network.request(MainRouters.details(id: id), decodeTo: RecipeDetailsModel.self, completionHandler: handler)
    }

}
