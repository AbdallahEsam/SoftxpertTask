
//  NoDataViewController.swift
//  VIP Base
//
//  Created by Abdallah Essam on 18/08/2022.
//  Copyright © 2022 Abdallah Essam. All rights reserved.
//

import UIKit

protocol NoDataViewControllerDelegate: AnyObject {
    func goToHomeBtnSelected()
}
class NoDataViewController: UIView {
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblTitle: UILabel!

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageLogo: UIImageView!

    private weak var delegate:NoDataViewControllerDelegate?
    func setData(image: UIImage, description: String?,title:String,delegate:NoDataViewControllerDelegate?,buttonText:String?) {
        if let description = description , description != "" {
            lblDesc.text = description
        }
        self.delegate = delegate
        imageLogo.image = image
        lblTitle.text = title
      
//        fadeIn()
    }
    func fadeIn(withDuration duration: TimeInterval = 1.0) {
        imageLogo.alpha = 0
        UIView.animate(withDuration: duration, animations: {
            self.imageLogo.alpha = 1.0
        })
    }
   
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        commenInitialization()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commenInitialization()
    }

    func commenInitialization() {
        Bundle.main.loadNibNamed("NoDataView", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
       
    
    }
    
    @IBAction func goHomeBtnSelected(){
        delegate?.goToHomeBtnSelected()
//        AuthService.goToHomeScreenAfterLogin()
    }
}
