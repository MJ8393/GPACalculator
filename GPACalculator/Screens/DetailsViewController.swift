//
//  DetailsViewController.swift
//  GPACalculator
//
//  Created by Mekhriddin Jumaev on 10/02/23.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var collectionView: UICollectionView!
    
    var index = 1
    
    lazy var customSegmentedControl = CustomSegmentControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        self.navigationItem.titleView = twoLineTitleView(text: "Grading")
        navigationController?.backgroundColor(backgroundcolor: UIColor.white)
        configureCollectionView()
        setContstraints()
    }
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createTreeCoulumbFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.clipsToBounds = true
        collectionView.backgroundColor = .white
        collectionView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        collectionView.layer.shadowOpacity = 1
        collectionView.layer.shadowRadius = 8
        collectionView.layer.shadowOffset = CGSize(width: 0, height: 0)
        collectionView.layer.cornerRadius = 10
//        collectionView.layer.masksToBounds = false
        collectionView.register(ScaleCollectionViewCell.self, forCellWithReuseIdentifier: ScaleCollectionViewCell.reuseID)
    }
    
    private func setContstraints() {
        customSegmentedControl.gradingSystemTapped = { [weak self] index in
            DispatchQueue.main.async {
                self?.index = index
                self?.collectionView.reloadData()
            }
        }
        view.addSubview(customSegmentedControl)
        customSegmentedControl.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(60)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(customSegmentedControl.snp.bottom).offset(20)
            make.bottom.equalTo(view)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
        }
    }
    
}

extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataGrades[index].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScaleCollectionViewCell.reuseID, for: indexPath) as? ScaleCollectionViewCell else { return UICollectionViewCell() }
        cell.setData(indexI: index, indexJ: indexPath.item)
        return cell
    }
}

var dataGrades: [[String]] = [
    [
        "Grade", "Percent (Absolute)", "Scale",
        "5", "90 - 100", "5.0",
        "4", "70 - 89.9", "4.0",
        "3", "60 - 69.9", "3.0",
        "F", "Below 59.9", "0.0",
    ],
    [
        "Grade", "Percent (Relative)", "Scale",
        "A+", "10", "4.5",
        "A0", "10", "4.0",
        "B+", "15", "3.5",
        "B0", "15", "3.0",
        "C+", "15", "2.5",
        "C0", "15", "2.0",
        "D+", "10", "1.5",
        "D0", "<=10", "1.0",
        "F", "<=10", "0.0",
    ],
    [
        "Grade", "Percent (Absolute)", "Scale",
        "A+", "97 - 100", "4.0",
        "A", "93 - 96", "4.0",
        "A-", "90 - 92", "3.7",
        "B+", "87 - 89", "3.3",
        "B", "83 - 86", "3.0",
        "B-", "80 - 82", "2.7",
        "C+", "77 - 79", "2.3",
        "C", "73 - 76", "2.0",
        "C-", "70 - 72", "1.7",
        "D+", "67 - 69", "1.3",
        "D", "65 - 66", "1.0",
        "F", "Below 65", "0.0",
    ]
]
