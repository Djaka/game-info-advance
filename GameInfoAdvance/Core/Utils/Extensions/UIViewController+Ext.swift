//
//  UIViewController+Ext.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 17/07/23.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = GameInfoAlert.alert(title: title, message: message)
        self.present(alert, animated: true)
    }
}
