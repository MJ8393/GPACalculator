//
//  SemesterTableViewCell.swift
//  GPACalculator
//
//  Created by Mekhriddin Jumaev.
//

import UIKit

class SemesterTableViewCell: UITableViewCell {
    
    lazy var mainLabel = MainLabel(text: "Semester 1", textColor: UIColor(named: "LabelColor")!, textAlignment: .left, font: UIFont(name: "Poppins-Regular", size: 16)!)
    var isUniversity: Bool = false
    
    var cellIndex: Int = 0
    var univerIndex: Int = 0
    var isOn: Bool = false
    
    var univerTapped : ((Int) -> Void)?
    
    lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        imageView.addGestureRecognizer(tap)
        return imageView
    }()
    
    static let reuseID = "SemesterTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setConstraints()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        if isUniversity {
            if isOn {
                mainImageView.image = UIImage(named: "off")
                isOn = false
                univerTapped!(-1)
            } else {
                mainImageView.image = UIImage(named: "on")
                isOn = true
                univerTapped!(univerIndex)
            }
            return
        }
        guard let marked = unSelectedSemesters[cellIndex].isMarked else { return }
        if marked {
            mainImageView.image = UIImage(named: "off")
            unSelectedSemesters[cellIndex].isMarked = false
        } else {
            mainImageView.image = UIImage(named: "on")
            unSelectedSemesters[cellIndex].isMarked = true
        }
    }
    
    func setData(semester: SemesterModel, index: Int) {
        mainLabel.text = semester.name
        cellIndex = index
        guard let marked = unSelectedSemesters[cellIndex].isMarked else { return }
        if marked {
            mainImageView.image = UIImage(named: "on")
        } else {
            mainImageView.image = UIImage(named: "off")
        }
    }
    
    func setUniversities(index: Int, isUniversity: Bool) {
        univerIndex = index
        mainLabel.text = universities[index]
        mainImageView.image = UIImage(named: "off")
        isOn = false
        self.isUniversity = isUniversity
    }

    private func addSubviews() {
        contentView.addSubview(mainImageView)
        mainImageView.isUserInteractionEnabled = true
        contentView.addSubview(mainLabel)
    }
    
    private func setConstraints() {
        mainImageView.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).offset(-32)
            make.centerY.equalTo(contentView)
            make.width.height.equalTo(25)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(32)
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(mainImageView.snp.leading).offset(-20)
        }
    }
}
