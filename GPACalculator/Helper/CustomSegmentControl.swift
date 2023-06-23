//
//  CustomSegmentControl.swift
//  GPACalculator
//
//  Created by Mekhriddin Jumaev.
//

import Foundation
import UIKit
import SwiftyShadow

class CustomSegmentControl: UIView {
    
    var gradingSystemTapped : ((Int) -> Void)?
    
    let width = UIScreen.main.bounds.width - 40
    var selectedIndex = 1 {
        didSet {
            if selectedIndex == oldValue {
                return
            }
            gradingSystemTapped!(selectedIndex)
            Vibration.light.vibrate()
        }
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        let testView = SwiftyInnerShadowView()
        self.addSubview(testView)
        testView.snp.makeConstraints { make in
            make.size.equalTo(self)
        }
        testView.backgroundColor = .white
        testView.shadowLayer.cornerRadius = 19
        testView.shadowLayer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        testView.shadowLayer.shadowOpacity = 1
        testView.shadowLayer.shadowRadius = 5
        testView.shadowLayer.shadowOffset = CGSize(width: 0, height: 0)
        testView.layer.masksToBounds = false
        setupView()
        
        usLabel.isUserInteractionEnabled = true
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.usTapped(_:)))
        usLabel.addGestureRecognizer(tap1)
        
        uzLabel.isUserInteractionEnabled = true
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.uzTapped(_:)))
        uzLabel.addGestureRecognizer(tap2)
        
        krLabel.isUserInteractionEnabled = true
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(self.krTapped(_:)))
        krLabel.addGestureRecognizer(tap3)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var deliverySwitcherView = {
        let view = UIView()
        view.backgroundColor = blueColor
        view.isUserInteractionEnabled = true
        view.layer.shadowColor = UIColor(red: 0.267, green: 0.267, blue: 0.267, alpha: 0.2).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 4
        view.layer.cornerRadius = 20
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.masksToBounds = false
        return view
    }()
    
    lazy var usLabel = MainLabel(text: "US(4.0)", textColor: UIColor.init(hex: "424D59"), textAlignment: .center, font: UIFont(name: "Poppins-Medium", size: 13)!)
    
    lazy var uzLabel = MainLabel(text: "UZ(5.0)", textColor:  UIColor.init(hex: "424D59"), textAlignment: .center, font: UIFont(name: "Poppins-Medium", size: 13)!)
    
    lazy var krLabel = MainLabel(text: "KR(4.5)", textColor:  UIColor.init(hex: "424D59"), textAlignment: .center, font: UIFont(name: "Poppins-Medium", size: 13)!)
    
    @objc private func usTapped(_ sender: UITapGestureRecognizer? = nil)  {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.deliverySwitcherView.frame.origin.x = self!.width * 2 / 3 + 6
        })
        selectedIndex = 2
    }
    
    @objc private func uzTapped(_ sender: UITapGestureRecognizer? = nil) {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.deliverySwitcherView.frame.origin.x = 6
        })
        selectedIndex = 0
    }
    
    @objc private func krTapped(_ sender: UITapGestureRecognizer? = nil) {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.deliverySwitcherView.frame.origin.x = self!.width * 1 / 3 + 6
        })
        selectedIndex = 1
    }
    
    private func setupView() {
        
        self.addSubview(deliverySwitcherView)
        deliverySwitcherView.snp.makeConstraints { make in
            make.top.equalTo(self).offset(6)
            make.leading.equalTo(self).offset(CGFloat(selectedIndex) * self.width / 3 + 6)
            make.trailing.equalTo(self).offset(-width * (2 - CGFloat(selectedIndex)) / 3 - 6)
            make.bottom.equalTo(self).offset(-6)
        }
        
        self.addSubview(uzLabel)
        uzLabel.snp.makeConstraints { make in
            make.leading.equalTo(self)
            make.trailing.equalTo(self).offset(-width * 2 / 3)
            make.top.bottom.equalTo(self)
        }
        
        self.addSubview(krLabel)
        krLabel.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(width * 1 / 3)
            make.trailing.equalTo(self).offset(-width * 1 / 3)
            make.top.bottom.equalTo(self)
        }
        
        self.addSubview(usLabel)
        usLabel.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(width * 2 / 3)
            make.trailing.equalTo(self)
            make.top.bottom.equalTo(self)
        }
    }
}

