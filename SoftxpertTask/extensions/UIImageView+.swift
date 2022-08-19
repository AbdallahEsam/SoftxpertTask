//
//  UIImageView+.swift
//  SoftxpertTask
//
//  Created by Abdallah Essam on 18/08/2022.
//  Copyright © 2022 Abdallah Essam. All rights reserved.
//

import Foundation
import SDWebImage

extension UIImageView {
    func load(with url: String?, cop: ((_ image: UIImage?) -> Void)? = nil) {
        let placeHolder = #imageLiteral(resourceName: "emptySearch")
        
        guard let urlString = url else { return }
        guard let url = URL(string: urlString) else { return }
        
        var activityIndicatorView: UIActivityIndicatorView
        
        if #available(iOS 13.0, *) {
            activityIndicatorView = UIActivityIndicatorView(style: .medium)
        } else {
            activityIndicatorView = UIActivityIndicatorView(style: .gray)
        }
        addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperview()
        activityIndicatorView.startAnimating()
        activityIndicatorView.color = .mainColor
        activityIndicatorView.isHidden = false
        activityIndicatorView.hidesWhenStopped = true
        let options: SDWebImageOptions = [.continueInBackground]
        
        sd_setImage(with: url, placeholderImage: placeHolder, options: options, progress: nil) {[weak self] (image, error, cache, url) in
            activityIndicatorView.removeFromSuperview()
            if image == nil {
                self?.image = placeHolder
                cop?(nil)
            } else {
                self?.image = image
                cop?(image)
            }
        }
    }
    
   
}

extension UIView{
    func centerInSuperview(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        centerXAnchor.constraint(equalTo: superview!.centerXAnchor).isActive = true
        
        centerYAnchor.constraint(equalTo: superview!.centerYAnchor).isActive = true
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}
