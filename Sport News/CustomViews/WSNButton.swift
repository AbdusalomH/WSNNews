//
//  WSNButton.swift
//  Sport News
//
//  Created by Abdusalom on 20/07/2024.
//

import UIKit

class WSNButton: UIButton {
 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String, titleColor: UIColor, backgroundColor: UIColor? = nil) {
        super.init(frame: .zero)
        configure()
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        //self.layer.opacity = opacity ?? 0
    }
    
    
    func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
    }
}
