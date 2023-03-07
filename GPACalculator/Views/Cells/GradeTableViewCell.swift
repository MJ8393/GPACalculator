//
//  GradeTableViewCell.swift
//  GPACalculator
//
//  Created by Mekhriddin Jumaev on 07/02/23.
//

import UIKit

class GradeTableViewCell: UITableViewCell {
    
    static let reuseID = "GradeTableViewCell"
    var index = 0
    
    var gradeTapped : ((Int) -> Void)?
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "SettingsCell")!
        view.layer.cornerRadius = 16
        return view
    }()
    
    lazy var mainLabel = MainLabel(text: "Calculus 1", textColor: UIColor(named: "LabelColor3")!, textAlignment: .left, font: UIFont(name: "Karla-Regular", size: 18)!)
    
    lazy var creditView = CreditView()
    lazy var gradeView = GradeView(index: index)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        addSubviews()
        setConstraints()
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        gradeView.addGestureRecognizer(tapGesture1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(subject: Subject) {
        mainLabel.text = subject.name
        gradeView.gradeLabel.text = subject.grade
        creditView.gradeLabel.text = String(subject.credits)
        creditView.creditCount = Int(subject.credits)
    }
    
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        print("Tap", index)
        gradeTapped?(index)
    }
    
    private func addSubviews() {
        contentView.addSubview(mainView)
        contentView.addSubview(mainLabel)
        contentView.addSubview(creditView)
        contentView.addSubview(gradeView)
    }
    
    private func setConstraints() {
        mainView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(20)
            make.trailing.equalTo(contentView).offset(-20)
            make.top.equalTo(contentView).offset(5)
            make.bottom.equalTo(contentView).offset(-5)
        }
        
        creditView.snp.makeConstraints { make in
            make.trailing.equalTo(mainView.snp.trailing).offset(-14)
            make.centerY.equalTo(contentView)
            make.width.equalTo(84)
            make.height.equalTo(35)
        }
        
        gradeView.snp.makeConstraints { make in
            make.trailing.equalTo(creditView.snp.leading).offset(-10)
            make.centerY.equalTo(contentView)
            make.width.equalTo(75)
            make.height.equalTo(35)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.leading.equalTo(mainView).offset(24)
            make.centerY.equalTo(mainView)
            make.trailing.equalTo(gradeView.snp.leading).offset(-10)
            
        }
    }
}

