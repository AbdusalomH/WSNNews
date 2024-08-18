//
//  WSNLogo.swift
//  Sport News
//
//  Created by Abdusalom on 03/07/2024.
//

import UIKit

class WSNLogo: UIImageView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        image = UIImage(named: "Logo")
        contentMode = .scaleAspectFill
    }
}
