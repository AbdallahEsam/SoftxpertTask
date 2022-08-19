//
//  MainButton.swift
//  VIP Base
//
//  Created by Abdallah Essam on 18/08/2022.
//  Copyright © 2022 Abdallah Essam. All rights reserved.
//


import UIKit
class MainButton: UIButton {

    var fontSize:CGFloat = 16
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        enableMe()
        layer.cornerRadius = 23
        titleLabel?.font = .systemFont(ofSize: fontSize)
    }

    func disableMe() {
        isEnabled = false
        layer.borderWidth = 0
        isUserInteractionEnabled = false
        tintColor = .buttonTextColorDisable
        setTitleColor(.buttonTextColorDisable, for: .normal)
        backgroundColor = .disableButtonColor
    }

    func enableMe() {
        isEnabled = true
        layer.borderWidth = 0
        isUserInteractionEnabled = true
        tintColor = .enableButtonTextColor
        setTitleColor(.enableButtonTextColor, for: .normal)
        backgroundColor = .mainColor
    }
}
