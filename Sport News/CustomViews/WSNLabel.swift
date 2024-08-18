//
//  WSNLabel.swift
//  Sport News
//
//  Created by Abdusalom on 03/07/2024.
//

import UIKit

class WSNLabel: UILabel {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(titleText: String, labelTextColor: UIColor, fontSize: CGFloat, weight: UIFont.Weight,  numberOfLines: Int, textAlighment: NSTextAlignment) {
        super.init(frame: .zero)
        configure()
        self.textColor = labelTextColor
        self.font = .systemFont(ofSize: fontSize, weight: weight)
        self.text = titleText
        self.textAlignment = textAlighment
        self.numberOfLines = numberOfLines
        self.minimumScaleFactor = 0.2
        self.adjustsFontSizeToFitWidth = true
    }
    
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        minimumScaleFactor = 0.5
    }
}
