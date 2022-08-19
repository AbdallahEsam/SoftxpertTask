//
//  NSObject+.swift
//  SoftxpertTask
//
//  Created by Abdallah Essam on 18/08/2022.
//  Copyright © 2022 Abdallah Essam. All rights reserved.
//


import UIKit
extension NSObject {
    class var className: String {
        return "\(self)"
    }
    
    var jsonToString: String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    func cast<T: Any>(to type: T.Type) -> T? {
        return self as? T
    }
    
    func forceCast<T: Any>(to type: T.Type) -> T {
        return self as! T
    }
}
