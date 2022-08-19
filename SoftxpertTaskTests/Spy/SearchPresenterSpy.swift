//
//  SearchPresenterSpy.swift
//  SoftxpertTaskTests
//
//  Created by Abdallah Essam on 18/08/2022.
//  Copyright © 2022 Abdallah Essam. All rights reserved.
//


import Foundation
@testable import SoftxpertTask

class SearchPresenterSpy: SearchInteractorPresenterProtocol {
    
    var isFetchDataSuccessfullyCalled = false
    var isFetchAnErrorCalled = false
    
    
    func fetchDataSuccessfully(data: SearchRecipe) {
        isFetchDataSuccessfullyCalled = true
    }
    
    func fetchAnError(error: AppError) {
        isFetchAnErrorCalled = true
    }
    
    
}
