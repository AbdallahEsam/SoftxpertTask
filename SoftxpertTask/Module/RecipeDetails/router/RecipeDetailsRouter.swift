//
//  RecipeDetailsRouter.swift
//  SoftxpertTask
//
//  Created by Abdallah Essam on 18/08/2022.
//  Copyright © 2022 Abdallah Essam. All rights reserved.
//


import UIKit

protocol RecipeDetailsViewToRouterProtocol {
    func popMe()
}

class RecipeDetailsRouter {
    weak var sourceViewController: UIViewController?
    init(_ sourceViewController: UIViewController){
        self.sourceViewController = sourceViewController
    }
}

extension RecipeDetailsRouter: RecipeDetailsViewToRouterProtocol {
    func popMe() {
        
    }
   
}

