//
//  ChooseGradeCollectionViewCell.swift
//  GPACalculator
//
//  Created by Mekhriddin Jumaev.
//

import UIKit

class ChooseGradeCollectionViewCell: UICollectionViewCell {
    
    static let resuseID = "ChooseGradeCollectionViewCell"
    
    var cellIndex: Int = 0
    var currentIndex = 0
    var gradeChosen : ((Int) -> Void)?
    
    lazy var mainLabel = MainLabel(text: "A +", textColor: UIColor(named: "LabelColor")!, textAlignment: .left, font: UIFont.systemFont(ofSize: 16))
    
    lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "off")!
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        imageView.addGestureRecognizer(tap)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        mainImageView.image = UIImage(named: "on")!
        gradeChosen!(currentIndex)
    }
    
    func setData(grade: Grade, index: Int) {
        mainLabel.text = grade.name
        currentIndex = index
        if cellIndex == index {
            mainImageView.image = UIImage(named: "on")!
        }
    }
    
    private func addSubviews() {
        contentView.addSubview(mainImageView)
        mainImageView.isUserInteractionEnabled = true
        contentView.addSubview(mainLabel)
    }
    
    private func setConstraints() {
        mainImageView.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).offset(-20)
            make.centerY.equalTo(contentView)
            make.width.height.equalTo(25)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(20)
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(mainImageView.snp.leading).offset(-10)
        }
    }
    
    
}
