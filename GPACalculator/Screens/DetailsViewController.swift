//
//  DetailsViewController.swift
//  GPACalculator
//
//  Created by Mekhriddin Jumaev.
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
        collectionView.showsVerticalScrollIndicator = false
        collectionView.clipsToBounds = true
        collectionView.backgroundColor = .white
        collectionView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        collectionView.layer.shadowOpacity = 1
        collectionView.layer.shadowRadius = 8
        collectionView.layer.shadowOffset = CGSize(width: 0, height: 0)
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
            make.top.equalTo(customSegmentedControl.snp.bottom).offset(8)
            make.bottom.equalTo(view).offset(-20)
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
