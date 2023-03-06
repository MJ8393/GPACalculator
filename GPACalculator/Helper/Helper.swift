//
//  Helper.swift
//  GPACalculator
//
//  Created by Mekhriddin Jumaev on 07/02/23.
//

import UIKit

struct UIHelper {
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let with = view.bounds.width
        let padding: CGFloat = 12
        let minumumItemSpacing: CGFloat  = 10
        let availableWith = with - (padding * 2) - (minumumItemSpacing * 2)
        let itemWith  = availableWith / 3
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWith, height: 50)
        return flowLayout
    }
    
    static func createTreeCoulumbFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width - 40
        let padding: CGFloat = 0
        let minumumItemSpacing: CGFloat = 1
        let availableWidth = width - (padding * 2) - (minumumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: 50)
        flowLayout.minimumLineSpacing = 1
        flowLayout.minimumInteritemSpacing = 1
        return flowLayout
    }
    
}
