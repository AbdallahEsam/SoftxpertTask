//
//  MainRepoMock.swift
//  SoftxpertTaskTests
//
//  Created by Abdallah Essam on 18/08/2022.
//  Copyright © 2022 Abdallah Essam. All rights reserved.
//


import Foundation
@testable import SoftxpertTask

class MainRepoMock {
    var isSearchApiCalled: Bool =  false
    var isDetailsApiCalled: Bool =  false
    
    var searchCompletion: NetworkCompletion<SearchRecipe>?
    var detailsCompletion: NetworkCompletion<RecipeDetailsModel>?
    
    
    func simulateGettingSearchSuccessResponse() {
        searchCompletion?(.success(SearchStub.createSearch()))
    }
    
    func simulateGettingSearchErrorResponse() {
        searchCompletion?(.failure(.noInternet))
    }
}


extension MainRepoMock: MainRepoProtocol {
    func search(searchKey: String?, filter: FilterEnum?, from: Int, handler: @escaping  NetworkCompletion<SearchRecipe>) {
        isSearchApiCalled = true
        self.searchCompletion = handler
    }
    
    func recipeDetails(id: String, handler: @escaping  NetworkCompletion<RecipeDetailsModel>) {
        isDetailsApiCalled = true
        self.detailsCompletion = handler
    }
}
