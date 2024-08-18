//
//  GradientLayer.swift
//  Sport News
//
//  Created by Abdusalom on 03/07/2024.
//

import UIKit


class GradientContainerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientBackground()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradientBackground()
    }
    
    private func setupGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.black.withAlphaComponent(1).cgColor, // Темный цвет внизу
            UIColor.clear.cgColor // Прозрачный цвет сверху
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.frame = self.bounds
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let gradientLayer = self.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = self.bounds
        }
    }
}
