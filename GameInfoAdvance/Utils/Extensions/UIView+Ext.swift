//
//  UIView+Ext.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 18/08/23.
//

import UIKit

@IBDesignable
extension UIView {
    
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
