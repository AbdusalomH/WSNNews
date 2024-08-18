//
//  CommentCell.swift
//  Sport News
//
//  Created by Abdusalom on 07/07/2024.
//

// ячейка комментов

import UIKit

class CommentCell: UITableViewCell {
    
    static let reuseID = "CommentCell"
    
    lazy var commentOwner: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(resource: .ava)
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var ownerName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    lazy var commentDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    lazy var commentText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    lazy var likesIcon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "likes")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var likesCount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .left
        label.textColor = .lightGray
        return label
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        
        let currentViews = [commentOwner, ownerName, commentDate, commentText, likesIcon, likesCount]
        
        for i in currentViews {
            contentView.addSubview(i)
        }
        
        NSLayoutConstraint.activate([
            
            commentOwner.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            commentOwner.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            commentOwner.heightAnchor.constraint(equalToConstant: 40),
            commentOwner.widthAnchor.constraint(equalToConstant: 40),
            
            ownerName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            ownerName.leadingAnchor.constraint(equalTo: commentOwner.trailingAnchor, constant: 8),
            ownerName.heightAnchor.constraint(equalToConstant: 20),
            
            commentDate.topAnchor.constraint(equalTo: ownerName.bottomAnchor, constant: 5),
            commentDate.leadingAnchor.constraint(equalTo: commentOwner.trailingAnchor, constant: 8),
            commentDate.heightAnchor.constraint(equalToConstant: 14),
            commentDate.widthAnchor.constraint(equalToConstant: 100),
            
            commentText.topAnchor.constraint(equalTo: commentOwner.bottomAnchor, constant: 20),
            commentText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            commentText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            likesIcon.topAnchor.constraint(equalTo: commentText.bottomAnchor, constant: 20),
            likesIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            likesIcon.heightAnchor.constraint(equalToConstant: 30),
            likesIcon.widthAnchor.constraint(equalToConstant: 30),
            likesIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            likesCount.centerYAnchor.constraint(equalTo: likesIcon.centerYAnchor),
            likesCount.leadingAnchor.constraint(equalTo: likesIcon.trailingAnchor, constant: 8),
            likesCount.heightAnchor.constraint(equalToConstant: 20),
            likesCount.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        ownerName.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        commentDate.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        commentText.setContentHuggingPriority(.defaultHigh, for: .vertical)
        likesCount.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    func setupViewData(commentdata: CommentsModel) {
        
        self.ownerName.text = commentdata.username
        self.commentDate.text = commentdata.commentTime
        self.commentText.text = commentdata.commentText
        self.likesCount.text = "\(commentdata.likeCount) likes"
        
    }
}
