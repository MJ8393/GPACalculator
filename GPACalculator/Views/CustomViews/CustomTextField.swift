//
//  CustomTextField.swift
//  GPACalculator
//
//  Created by Mekhriddin Jumaev on 08/02/23.
//

import UIKit


class AITextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init() {
        super.init(frame: .zero)
        self.layer.borderColor = UIColor.gray.withAlphaComponent(0.2).cgColor
        self.layer.borderWidth = 1.5
        self.layer.cornerRadius = 16
        self.autocorrectionType = .no
        self.layer.masksToBounds = false
        self.rightViewMode = .always
        self.tintColor = blueColor
        self.textColor = UIColor.init(hex: "494949")
        self.font = UIFont(name: "Poppins-Medium", size: 16)!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
}
