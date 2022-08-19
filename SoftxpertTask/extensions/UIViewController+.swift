//
//  UIViewController+.swift
//  SoftxpertTask
//
//  Created by Abdallah Essam on 18/08/2022.
//  Copyright © 2022 Abdallah Essam. All rights reserved.
//


import UIKit

extension UIViewController{
    func presentActivityControl(shareContent:[Any]){
        let activityController = UIActivityViewController(activityItems: shareContent,applicationActivities: nil)
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let popup = activityController.popoverPresentationController {
                popup.sourceView = self.view
                popup.sourceRect = CGRect(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 4, width: 0, height: 0)
            }
        }
        self.present(activityController, animated: true, completion: nil)
    }
    
    func openURL(url: String) {
        if let url = URL(string: url),
           UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url, options: [:]) { (opened) in
                if(opened){
                    print("URL Opened")
                }
            }
        } else {
            print("Can't Open URL on Simulator")
        }
    }
    
}
