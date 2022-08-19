//
//  TableViewExtension.swift
//  VIP Base
//
//  Created by Abdallah Essam on 18/08/2022.
//  Copyright © 2022 Abdallah Essam. All rights reserved.
//

import Foundation
import UIKit
extension UITableView {
    
    func setEmptyData(image:UIImage,description:String ,title:String,delegate:NoDataViewControllerDelegate?, buttonText:String? = nil ) {
        let vc = NoDataViewController(frame: .zero)
        vc.setData(image: image, description: description, title: title, delegate: delegate, buttonText: buttonText)
        backgroundView = vc
    }
    
   
    func removeBackGroundView(){
        backgroundView = nil
    }
}

extension UICollectionView {
    func setEmptyData(image:UIImage,description:String ,title:String ,delegate:NoDataViewControllerDelegate?,buttonText:String? = nil ) {
        let vc = NoDataViewController(frame: .zero)
        vc.setData(image: image, description: description, title: title, delegate: delegate, buttonText: buttonText)
        backgroundView = vc
    }
    
   
    func removeBackGroundView(){
        backgroundView = nil
    }
}
