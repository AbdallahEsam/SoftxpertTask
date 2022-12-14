//
//  HandleResponseError.swift
//  VIP Base
//
//  Created by Abdallah Essam on 18/08/2022.
//  Copyright © 2022 Abdallah Essam. All rights reserved.
//

import UIKit

protocol AppErrorViewsProtocol {
    func showNoInternetView(show: Bool, deleget: NoInternetDelegate?)
    func showTimeRequestOutView(show: Bool, deleget: NoInternetDelegate?)
    func showServerErrorView(show: Bool, deleget: NoInternetDelegate?)
}

extension AppErrorViewsProtocol where Self: UIViewController {
    
    func showNoInternetView(show: Bool, deleget: NoInternetDelegate?) {
        self.showNoInterNetView(show: show, deleget: deleget, errorType: .noInternet)
    }
    
    func showTimeRequestOutView(show: Bool, deleget: NoInternetDelegate?, mainView:UIView?) {
        self.showNoInterNetView(show: show, deleget: deleget, errorType: .timeRequestOut)
    }
    
    func showServerErrorView(show: Bool, deleget: NoInternetDelegate?, mainView:UIView?){
        self.showNoInterNetView(show: show, deleget: deleget, errorType: .serverError)
    }
    
}

