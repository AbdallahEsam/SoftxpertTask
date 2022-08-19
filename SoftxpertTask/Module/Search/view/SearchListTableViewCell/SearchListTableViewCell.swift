//
//  SearchListTableViewCell.swift
//  SoftxpertTask
//
//  Created by Macintosh on 18/08/2022.
//

import UIKit


class SearchListTableViewCell: UITableViewCell {
    @IBOutlet private weak var recipeImageView: UIImageView!
    @IBOutlet private weak var recipeTitleLabel: UILabel!
    @IBOutlet private weak var recipeSourceLabel: UILabel!
    @IBOutlet private weak var recipeHealthLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configCell(vm: SearchListViewModel) {
        recipeImageView.load(with: vm.imageURL)
        recipeTitleLabel.text = vm.title
        recipeSourceLabel.text = vm.source
        recipeHealthLabel.text = vm.health
        
    }
}
