//
//  FavoritesSelectionCell.swift
//  Sport News
//
//  Created by Abdusalom on 29/06/2024.
//

import UIKit
import Kingfisher

final class FavoritesSelectionCell: UICollectionViewCell {
    
    static let reuseID = "favoriteCell"
    
    
    lazy var favoriteImage: UIImageView = {
        
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        image.isSkeletonable = true
        return image
    }()
    
    
    lazy var imageTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.opacity = 0
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
        
    }()
    
    lazy var checkMark: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "Vector")
        image.contentMode = .scaleAspectFill
        image.layer.opacity = 0
        return image
    }()
 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        isSkeletonable = true
        setupView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
        
        contentView.addSubview(favoriteImage)
        contentView.addSubview(imageTitle)
        contentView.addSubview(containerView)
        contentView.addSubview(checkMark)

        
        NSLayoutConstraint.activate([
            
            favoriteImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            favoriteImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            favoriteImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            favoriteImage.heightAnchor.constraint(equalTo: favoriteImage.widthAnchor),
            
            imageTitle.topAnchor.constraint(equalTo: favoriteImage.bottomAnchor, constant: 8),
            imageTitle.leadingAnchor.constraint(equalTo: favoriteImage.leadingAnchor),
            imageTitle.trailingAnchor.constraint(equalTo: favoriteImage.trailingAnchor),
            imageTitle.heightAnchor.constraint(equalToConstant: 16),
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            containerView.heightAnchor.constraint(equalTo: favoriteImage.widthAnchor),
            
            checkMark.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            checkMark.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkMark.heightAnchor.constraint(equalToConstant: 20),
            checkMark.widthAnchor.constraint(equalToConstant: 15),
        ])
    }
    
    func setupContet(newItem: CategoriesModel) {
        let url = URL(string: newItem.image)
        self.favoriteImage.kf.setImage(with: url)
        self.imageTitle.text = newItem.title
        self.checkMark.layer.opacity = newItem.followed_by_user ? 1 : 0
        self.containerView.layer.opacity = newItem.followed_by_user ? 0.7 : 0
    }
    
    
    func setupContentForFavorites(fav: CategoriesModel) {
        let url = URL(string: fav.image)
        self.favoriteImage.kf.setImage(with: url)
        self.imageTitle.text = fav.title
    }
}
