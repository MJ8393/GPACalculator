//
//  NewMainViewController.swift
//  GPACalculator
//
//  Created by Mekhriddin Jumaev on 24/07/23.
//

import UIKit

class NewMainViewController: UIViewController {
    
    lazy var subView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        // Create a layout object (e.g., UICollectionViewFlowLayout)
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 12, left: 15, bottom: 0, right: 15)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(PaymenyTypeCollectionCell.self, forCellWithReuseIdentifier: String(describing: PaymenyTypeCollectionCell.self))
        collectionView.register(PaymentCollectionCell.self, forCellWithReuseIdentifier: String(describing: PaymentCollectionCell.self))
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension NewMainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
            
        if indexPath.row % 4 == 0 || indexPath.row % 4 == 3  {
            let c = collectionView.dequeueReusableCell(withReuseIdentifier: String.init(describing: PaymenyTypeCollectionCell.self), for: indexPath) as! PaymenyTypeCollectionCell
//            c.initCell(elem: Any.self)
            cell = c
        } else {
            let c = collectionView.dequeueReusableCell(withReuseIdentifier: String.init(describing: PaymentCollectionCell.self), for: indexPath) as! PaymentCollectionCell
//            c.initCell(elem: Any.self)
            cell = c
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = UIScreen.main.bounds.width - 3 * 15
        if indexPath.row % 4 == 0 || indexPath.row % 4 == 3 {
            return CGSize(width: availableWidth * 0.4, height: 100)
        } else {
            return CGSize(width: availableWidth * 0.6, height: 100)
        }
    }
}
