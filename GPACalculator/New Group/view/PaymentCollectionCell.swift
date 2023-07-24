//
//  PaymentCollectionCell.swift
//  GPACalculator
//
//  Created by Mekhriddin Jumaev on 24/07/23.
//

import UIKit

class PaymentCollectionCell: UICollectionViewCell {
    
    lazy var subView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 22
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func initViews() {
        contentView.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
}
