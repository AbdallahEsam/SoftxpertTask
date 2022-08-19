//
//  SearchRouter.swift
//  SoftxpertTask
//
//  Created by Abdallah Essam on 18/08/2022.
//  Copyright © 2022 Abdallah Essam. All rights reserved.
//


import UIKit
protocol SearchViewToRouterProtocol {
    func navigateToDetailsWithID(_ id: String)
    
}

class SearchRouter {
    weak var sourceViewController: UIViewController?
    init(_ sourceViewController: UIViewController){
        self.sourceViewController = sourceViewController
    }
}

extension SearchRouter: SearchViewToRouterProtocol {
    func navigateToDetailsWithID(_ id: String) {
        let vc = MainConfigurator.details(id: id)
        sourceViewController?.navigationController?.pushViewController(vc, animated: true)
    }
   
}

