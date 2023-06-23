//
//  Ext+UINavigationContoll.swift
//  GPACalculator
//
//  Created by Mekhriddin Jumaev.
//

import UIKit

extension UINavigationController {
    
    func backgroundColor(backgroundcolor: UIColor) {
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.barTintColor = UIColor(named: "BackgroundColor")
    }
}
