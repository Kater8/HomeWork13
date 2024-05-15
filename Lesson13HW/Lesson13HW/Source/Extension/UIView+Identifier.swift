//
//  UIView+Identifier.swift
//  Lesson13HW
//

//

import UIKit

extension UIView {
    
    var reuseIdentifier: String {
        get {
            return String(describing: self)
        }
    }
}
