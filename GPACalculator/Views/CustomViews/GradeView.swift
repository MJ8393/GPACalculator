//
//  GradeView.swift
//  GPACalculator
//
//  Created by Mekhriddin Jumaev.
//

import UIKit

class GradeView: UIView {
    
    lazy var gradeLabel = MainLabel(text: "B +", textColor: UIColor.init(hex: "494949"), textAlignment: .left, font: UIFont.systemFont(ofSize: 16))
    
    lazy var imageView = UIImageView(image: UIImage(named: "down"))

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(index: Int) {
        super.init(frame: .zero)
        gradeLabel.text = grades[index].name
        backgroundColor = .white
        layer.cornerRadius = 5
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { make in
            make.trailing.equalTo(self).offset(-12)
            make.centerY.equalTo(self)
            make.height.equalTo(14)
            make.width.equalTo(14)
        }
        
        self.addSubview(gradeLabel)
        gradeLabel.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(12)
            make.centerY.equalTo(self)
            make.trailing.equalTo(imageView.snp.leading).offset(0)
        }
        
        
    }
    
    
}
