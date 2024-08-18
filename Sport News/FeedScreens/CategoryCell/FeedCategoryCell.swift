//
//  FeedCategoryCell.swift
//  Sport News
//
//  Created by Abdusalom on 30/06/2024.
//

import UIKit
import SkeletonView

final class FeedCategoryCell: UICollectionViewCell {

    
    lazy var categoryName: WSNWithEdgesLabel = {
        let button = WSNWithEdgesLabel(withInsets: 5, 5, 10, 10)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.textAlignment = .center
        button.textColor = .gray
        button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.clipsToBounds = true
        return button
    }()
    
    
    static let reuseID = "feedCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //isSkeletonable = true
        setupView()
    }
     
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        
        self.contentView.addSubview(categoryName)
        
        NSLayoutConstraint.activate([
            categoryName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryName.topAnchor.constraint(equalTo: contentView.topAnchor),
            categoryName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    
    func setupData(name: String) {
        self.categoryName.text = name
    }

    
    override var isSelected: Bool {
        didSet {
            let currentBackgroundColor = categoryName.backgroundColor
            
            if currentBackgroundColor == #colorLiteral(red: 0.9595745206, green: 0.1748112142, blue: 0.06667741388, alpha: 1) {
                categoryName.isUserInteractionEnabled = false
            }
            
            categoryName.isUserInteractionEnabled = isSelected ? true : false
            categoryName.backgroundColor = isSelected ? #colorLiteral(red: 0.9595745206, green: 0.1748112142, blue: 0.06667741388, alpha: 1) : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            categoryName.textColor = isSelected ? .white : .gray
        }
    }
    
    
    override var isHighlighted: Bool {
        didSet {
            categoryName.backgroundColor = isHighlighted ? #colorLiteral(red: 0.9595745206, green: 0.1748112142, blue: 0.06667741388, alpha: 1) : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            categoryName.textColor = isSelected ? .white : .white
        }
    }
}

