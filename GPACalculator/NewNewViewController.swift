//
//  NewNewViewController.swift
//  GPACalculator
//
//  Created by Mekhriddin Jumaev on 27/06/23.
//

import UIKit

class NewNewViewController: UIViewController {
    
    var password: String = ""
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.backgroundColor = .lightGray
        textField.layer.cornerRadius = 10
        textField.delegate = self
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(250)
        }
    }

}

extension NewNewViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        return true
        
    }
}


