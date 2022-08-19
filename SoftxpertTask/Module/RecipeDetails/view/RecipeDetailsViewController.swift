//
//  RecipeDetailsViewController.swift
//  SoftxpertTask
//
//  Created by Abdallah Essam on 18/08/2022.
//  Copyright © 2022 Abdallah Essam. All rights reserved.
//


import UIKit
protocol RecipeDetailsViewProtocol: AlertHandlerViewProtocol, LoaderViewProtocol {
    func displayImageWithURL(_ url: String?)
    func displayTitle(_ title: String?)
    func displayIngredientLines(_ ingredientLines: String?)
}

class RecipeDetailsViewController: UIViewController {
    @IBOutlet private weak var recipeImageView: UIImageView!
    @IBOutlet private weak var recipeTitleLabel: UILabel!
    @IBOutlet private weak var ingredientLinesTextView: UITextView!

    var presenter: RecipeDetailsPresenterProtocol!
    var router: RecipeDetailsViewToRouterProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()

        title = Localization.string(for: .recipeDetailsTitle)
        presenter.viewDidLoad()
        addNavigationRightButton()
    }
    
    
    private func addNavigationRightButton() {
        let item = UIBarButtonItem(image: .shareIcon, style: .plain, target: self, action: #selector(shareRecipeLink))
        self.navigationItem.rightBarButtonItem = item
    }

    @objc private func shareRecipeLink() {
        let shareContent: [Any] = [presenter.recipeURL]
        self.presentActivityControl(shareContent: shareContent)
    }
    
    @IBAction private func recipeWebsiteButtonTapped() {
        openURL(url: presenter.recipeURL)
    }
    
}

extension RecipeDetailsViewController: RecipeDetailsViewProtocol {
    func displayImageWithURL(_ url: String?) {
        recipeImageView.load(with: url)
    }
    
    func displayTitle(_ title: String?) {
        recipeTitleLabel.text = title
    }
    
    func displayIngredientLines(_ ingredientLines: String?) {
        ingredientLinesTextView.text = ingredientLines
    }
    
}
