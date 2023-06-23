//
//  File.swift
//  Halol&Harom
//
//  Created by Mekhriddin.
//

import UIKit

class MainButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String) {
        self.init(frame: .zero)
        self.backgroundColor = UIColor.init(hex: "#38BCF4")
        self.setTitle(title, for: .normal)
        configure()
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 16
        titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 17)
        adjustsImageWhenHighlighted = false
    }
    
    func draw() {
            updateLayerProperties()
        }

        func updateLayerProperties() {
            self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            self.layer.shadowOffset = CGSize(width: 0, height: 3)
            self.layer.shadowOpacity = 1.0
            self.layer.shadowRadius = 10.0
            self.layer.masksToBounds = false
        }

}

