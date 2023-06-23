//
//  Ext+UIViewController.swift
//  GPACalculator
//
//  Created by Mekhriddin Jumaev.
//

import UIKit

extension UIViewController {
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(alertTitle: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle  = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func twoLineTitleView(text: String) -> UILabel {
        let label = UILabel(frame: CGRect(x: 0,
                                          y: 0,
                                          width: UIScreen.main.bounds.width - 250,
                                          height: 44))
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.font = UIFont(name: "Poppins-SemiBold", size: 20)
        label.textAlignment = .center
        label.textColor = UIColor(named: "LabelColor")
        label.lineBreakMode = .byWordWrapping
        label.text = text
        return label
    }
}
