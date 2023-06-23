//
//  File.swift
//  Halol&Harom
//
//  Created by Mekhriddin Jumaev.
//

import UIKit

class MainLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(text: String, textColor: UIColor, textAlignment: NSTextAlignment, font: UIFont) {
        self.init(frame: .zero)
        self.text = text
        self.textAlignment = textAlignment
        self.textColor = textColor
        self.font = font
    }
    
    
    private func configure() {
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
        textColor = UIColor.label
    }
}
