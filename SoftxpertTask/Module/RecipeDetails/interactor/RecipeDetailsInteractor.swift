//
//  RecipeDetailsInteractor.swift
//  SoftxpertTask
//
//  Created by Abdallah Essam on 18/08/2022.
//  Copyright © 2022 Abdallah Essam. All rights reserved.
//


import Foundation
protocol RecipeDetailsInteractorPresenterProtocol: AnyObject {
    func fetchDataSuccessfully(data: RecipeDetailsModel)
    func fetchAnError(error: AppError)
}
protocol RecipeDetailsInteractorProtocol{
    func recipeDetails(id: String)
}

class RecipeDetailsInteractor{
    private weak var presenter: RecipeDetailsInteractorPresenterProtocol!
    private let repo: MainRepoProtocol
    init(repo: MainRepoProtocol, presenter: RecipeDetailsInteractorPresenterProtocol){
        self.repo = repo
        self.presenter = presenter
    }
}

extension RecipeDetailsInteractor: RecipeDetailsInteractorProtocol {
    func recipeDetails(id: String) {
        repo.recipeDetails(id: id) { [weak self] rslt in
            guard let self = self else{return}
            switch rslt {
            case .success(let data):
                self.presenter.fetchDataSuccessfully(data: data)
            case .failure(let error):
                self.presenter.fetchAnError(error: error)
            }
        
        }
    }
}
