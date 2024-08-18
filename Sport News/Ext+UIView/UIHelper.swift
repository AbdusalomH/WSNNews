//
//  UIHelper.swift
//  Sport News
//
//  Created by Abdusalom on 08/07/2024.
//

import UIKit

class UIHelper {
    
    static func twoColumnsView(view: UIView) -> UICollectionViewLayout {
        
        let width = view.bounds.width
        let padding: CGFloat = 10
        let minimumSpacing: CGFloat = 10
        let availableWidth = width - (2 * padding) - minimumSpacing
        let cellWidth = availableWidth / 2
        let flawlayout = UICollectionViewFlowLayout()
        flawlayout.scrollDirection = .vertical
        flawlayout.minimumLineSpacing = minimumSpacing
        flawlayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        
        flawlayout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        return flawlayout
    } 
}


