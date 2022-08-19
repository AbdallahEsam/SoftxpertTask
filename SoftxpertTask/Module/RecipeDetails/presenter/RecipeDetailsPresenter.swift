//
//  RecipeDetailsPresenter.swift
//  SoftxpertTask
//
//  Created by Abdallah Essam on 18/08/2022.
//  Copyright © 2022 Abdallah Essam. All rights reserved.
//


import Foundation
protocol RecipeDetailsPresenterProtocol {
    func viewDidLoad()
    var recipeURL: String {get}
}

class RecipeDetailsPresenter {
    private weak var view: RecipeDetailsViewProtocol?
    var interactor: RecipeDetailsInteractorProtocol!
    private let id: String
   
    init(view: RecipeDetailsViewProtocol, id: String) {
        self.view = view
        self.id = id
    }
    
    private var _recipeURL: String?
}

extension RecipeDetailsPresenter: RecipeDetailsPresenterProtocol {
    var recipeURL: String {
        return _recipeURL ?? ""
    }
    
    func viewDidLoad() {
        view?.startLoading()
        interactor.recipeDetails(id: id)
    }
}

extension RecipeDetailsPresenter: RecipeDetailsInteractorPresenterProtocol {
    func fetchDataSuccessfully(data: RecipeDetailsModel) {
        view?.stopLoading()
        self._recipeURL = data.recipe?.shareAs
        view?.displayImageWithURL(data.recipe?.image)
        view?.displayTitle(data.recipe?.label)
        view?.displayIngredientLines(data.recipe?.ingredientLines?.joined(separator: "\n"))
    }
    
    func fetchAnError(error: AppError) {
        view?.stopLoading()
        view?.showAlert(with: error.description, title: .error)
    }
    
    
}
