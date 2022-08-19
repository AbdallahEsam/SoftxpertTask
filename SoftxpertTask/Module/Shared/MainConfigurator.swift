//
//  MainConfigurator.swift
//  SoftxpertTask
//
//  Created by Abdallah Essam on 18/08/2022.
//  Copyright © 2022 Abdallah Essam. All rights reserved.
//

import UIKit

import UIKit
struct MainConfigurator {
    
    static func search() ->  UIViewController{
        let network = Network()
        let mainRepo = MainRepo(network: network)
        let view = SearchViewController()
        let presenter = SearchPresenter(view: view)
        let interactor = SearchInteractor(repo: mainRepo, presenter: presenter)
        let router = SearchRouter(view)
        presenter.interactor = interactor
        view.presenter = presenter
        view.router = router
        return view
    }
    
    
    static func details(id: String) ->  UIViewController{
        let network = Network()
        let mainRepo = MainRepo(network: network)
        let view = RecipeDetailsViewController()
        let presenter = RecipeDetailsPresenter(view: view, id: id)
        let interactor = RecipeDetailsInteractor(repo: mainRepo, presenter: presenter)
        let router = RecipeDetailsRouter(view)
        presenter.interactor = interactor
        view.presenter = presenter
        view.router = router
        return view
    }
}
