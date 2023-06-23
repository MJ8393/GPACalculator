//
//  ScaleCollectionViewCell.swift
//  GPACalculator
//
//  Created by Mekhriddin Jumaev.
//

import UIKit

class ScaleCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "ScaleCollectionViewCell"

    
    lazy var mainLabel = MainLabel(text: "A+", textColor: UIColor(named: "LabelColor")!, textAlignment: .center, font: UIFont(name: "Poppins-Medium", size: 15)!)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        contentView.addSubview(mainLabel)
        mainLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView)
            make.centerY.equalTo(contentView)
        }
    }
    
    func setData(indexI: Int, indexJ: Int) {
        roundCorners([.bottomRight], radius: 0.0)
        mainLabel.text = dataGrades[indexI][indexJ]
        if indexJ <= 2 {
            contentView.backgroundColor = blueColor
            mainLabel.textColor = UIColor.white
            mainLabel.font = UIFont(name: "Poppins-Medium", size: 16)!
        } else {
            contentView.backgroundColor = UIColor.black.withAlphaComponent(0.04)
            mainLabel.textColor = UIColor(named: "LabelColor")!
            mainLabel.font = UIFont(name: "Poppins-Medium", size: 15)!
        }
        if dataGrades[indexI][indexJ] == "Grade" {
            roundCorners([.topLeft], radius: 10.0)
        } else if dataGrades[indexI][indexJ] == "Scale" {
            roundCorners([.topRight], radius: 10.0)
        } else if dataGrades[indexI][indexJ] == "F" {
            roundCorners([.bottomLeft], radius: 10.0)
        } else if dataGrades[indexI][indexJ] == "0.0" {
            roundCorners([.bottomRight], radius: 10.0)
        }
    }
    
    
}
