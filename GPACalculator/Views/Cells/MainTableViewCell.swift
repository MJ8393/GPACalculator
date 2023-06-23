//
//  MainTableViewCell.swift
//  GPACalculator
//
//  Created by Mekhriddin Jumaev.
//

import UIKit
import SwipeCellKit

class MainTableViewCell: SwipeTableViewCell {
    
    static let reuseID = "MainTableViewCell"
    
    lazy var myImageView = UIImageView(image: UIImage(named: "1")!)
    
    lazy var myLabel = MainLabel(text: "Semester 1", textColor: UIColor(named: "LabelColor")!, textAlignment: .left, font: UIFont(name: "Poppins-Regular", size: 18)!)
    
    lazy var gpaLabel1 = MainLabel(text: "GPA:", textColor: UIColor(named: "LabelColor2")!, textAlignment: .right, font: UIFont(name: "Poppins-Regular", size: 12)!)
    
    lazy var gpaLabel2 = MainLabel(text: "4.50", textColor: UIColor.init(hex: "F08F5F"), textAlignment: .left, font: UIFont(name: "Poppins-Medium", size: 12)!)
    
    lazy var creditLabel1 = MainLabel(text: "Credits:", textColor: UIColor(named: "LabelColor2")!, textAlignment: .right, font: UIFont(name: "Poppins-Regular", size: 12)!)
    
    lazy var creditLabel2 = MainLabel(text: "17", textColor: UIColor.init(hex: "F08F5F"), textAlignment: .left, font: UIFont(name: "Poppins-Medium", size: 12)!)
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: "B8C2C0").withAlphaComponent(0.7)
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(sem: Semester) {
        myImageView.image = UIImage(named: String(sem.key))
        myLabel.text = sem.name
        gpaLabel2.text = String(format: "%.2f", sem.gpa)
        creditLabel2.text = String(sem.credits)
    }
    
    private func addSubviews() {
        contentView.addSubview(myImageView)
        myImageView.contentMode = .scaleAspectFit
        contentView.addSubview(myLabel)
        contentView.addSubview(gpaLabel2)
        contentView.addSubview(gpaLabel1)
        contentView.addSubview(creditLabel1)
        contentView.addSubview(creditLabel2)
        contentView.addSubview(lineView)
    }
    
    private func setConstraints() {
        myImageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(16)
            make.centerY.equalTo(contentView)
            make.width.height.equalTo(24)
        }
        
        myLabel.snp.makeConstraints { make in
            make.leading.equalTo(myImageView.snp.trailing).offset(16)
            make.trailing.equalTo(contentView)
            make.centerY.equalTo(contentView)
        }
        
        gpaLabel2.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).offset(-60)
            make.bottom.equalTo(contentView.snp.centerY)
            make.width.equalTo(gpaLabel2.text!.widthOfString(usingFont: gpaLabel2.font) + CGFloat(2))
        }
        
        gpaLabel1.snp.makeConstraints { make in
            make.trailing.equalTo(gpaLabel2.snp.leading).offset(-5)
            make.bottom.equalTo(contentView.snp.centerY)
            make.width.equalTo(gpaLabel1.text!.widthOfString(usingFont: gpaLabel1.font) + CGFloat(2))
        }
        
        creditLabel2.snp.makeConstraints { make in
            make.leading.equalTo(creditLabel1.snp.trailing).offset(5)
            make.top.equalTo(contentView.snp.centerY)
            make.width.equalTo(creditLabel2.text!.widthOfString(usingFont: creditLabel2.font) + CGFloat(2))
        }
        
        creditLabel1.snp.makeConstraints { make in
            make.leading.equalTo(gpaLabel1)
            make.top.equalTo(contentView.snp.centerY)
            make.width.equalTo(creditLabel1.text!.widthOfString(usingFont: creditLabel1.font) + CGFloat(2))
        }
        
        lineView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
            make.trailing.equalToSuperview()
            make.leading.equalTo(20)
        }
    }
    
    

}

extension String {

    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }

    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }

    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
}
