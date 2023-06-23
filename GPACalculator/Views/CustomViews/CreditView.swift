//
//  CreditView.swift
//  GPACalculator
//
//  Created by Mekhriddin Jumaev.
//

import UIKit

class CreditView: UIView {
    
    var creditTapped : ((Int) -> Void)?
    
    var creditCount = 0
    
    lazy var gradeLabel = MainLabel(text: String(creditCount), textColor: UIColor.init(hex: "494949"), textAlignment: .center, font: UIFont.systemFont(ofSize: 16))
    
    lazy var imageView1 = UIImageView(image: UIImage(named: "minus"))
    lazy var imageView2 = UIImageView(image: UIImage(named: "plus1"))

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 5
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(handleTap1))
        imageView1.addGestureRecognizer(tapGesture1)
        imageView1.isUserInteractionEnabled = true
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(handleTap2))
        imageView2.addGestureRecognizer(tapGesture2)
        imageView2.isUserInteractionEnabled = true
        
        
        configureUI()
    }
    
    @objc func handleTap1(sender: UITapGestureRecognizer) {
        if creditCount != 0 {
            creditCount -= 1
            creditTapped?(creditCount)
            gradeLabel.text = String(creditCount)
        }
    }
    
    @objc func handleTap2(sender: UITapGestureRecognizer) {
        creditCount += 1
        creditTapped?(creditCount)
        gradeLabel.text = String(creditCount)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.addSubview(imageView1)
        imageView1.contentMode = .scaleAspectFit
        imageView1.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(10)
            make.centerY.equalTo(self)
            make.width.equalTo(16)
            make.height.width.equalTo(35)
        }
        
        self.addSubview(imageView2)
        imageView2.contentMode = .scaleAspectFit
        imageView2.snp.makeConstraints { make in
            make.trailing.equalTo(self).offset(-10)
            make.centerY.equalTo(self)
            make.width.equalTo(16)
            make.height.width.equalTo(35)
        }
        
        self.addSubview(gradeLabel)
        gradeLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView1.snp.trailing)
            make.trailing.equalTo(imageView2.snp.leading)
            make.centerY.equalTo(self)
        }
        
    }
}
