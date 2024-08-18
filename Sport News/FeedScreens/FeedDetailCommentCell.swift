//
//  FeedDetailCommentCell.swift
//  Sport News
//
//  Created by Abdusalom on 20/07/2024.
//

// FeedDetailCommentCell - ячейка коммента для в детялах новоестей

import UIKit

class FeedDetailCommentCell: UITableViewCell {
    
    
    static let reuseID = "FeedDetailCommentCell"
    
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "Comments"
        return label
    }()
    
    lazy var commentLabelCount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "234"
        return label
    }()
    
    lazy var commentArrow: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .arrow)
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var commentOwner: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .ava)
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var commentTexfield: UITextField = {
        let text = UITextField()
        text.placeholder = "Enter a comment"
        text.backgroundColor = #colorLiteral(red: 0.1803922057, green: 0.1803922057, blue: 0.1803922057, alpha: 1)
        text.layer.cornerRadius = 10
        text.textColor = .white
        text.clipsToBounds = true
        text.isEnabled = false
        
        // Изменение цвета placeholder
        text.attributedPlaceholder = NSAttributedString(
            string: "Enter a comment",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        
        // Добавление отступов
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: text.frame.height))
        text.leftView = paddingView
        text.leftViewMode = .always
        return text
    }()
     
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
        backgroundColor = .black
        isSkeletonable = true
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setupView() {
        
        let cellViews = [containerView, commentLabel, commentLabelCount, commentArrow, commentOwner, commentTexfield]
        
        
        commentLabel.isSkeletonable = true
        commentLabelCount.isSkeletonable = true
        commentOwner.isSkeletonable = true
        commentTexfield.isSkeletonable = true
        
        
        for i in cellViews {
            i.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(i)
            
        }
        
        
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 120),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            commentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            commentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            commentLabel.heightAnchor.constraint(equalToConstant: 20),
            
            commentLabelCount.leadingAnchor.constraint(equalTo: commentLabel.trailingAnchor, constant: 14),
            commentLabelCount.centerYAnchor.constraint(equalTo: commentLabel.centerYAnchor),
            commentLabelCount.heightAnchor.constraint(equalToConstant: 20),
            
            commentArrow.leadingAnchor.constraint(equalTo: commentLabelCount.trailingAnchor, constant: 8),
            commentArrow.centerYAnchor.constraint(equalTo: commentLabelCount.centerYAnchor),
            commentArrow.heightAnchor.constraint(equalToConstant: 10),
            
            commentOwner.topAnchor.constraint(equalTo: commentLabel.bottomAnchor, constant: 12),
            commentOwner.leadingAnchor.constraint(equalTo: commentLabel.leadingAnchor),
            commentOwner.heightAnchor.constraint(equalToConstant: 30),
            commentOwner.widthAnchor.constraint(equalToConstant: 30),
            commentOwner.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            commentTexfield.centerYAnchor.constraint(equalTo: commentOwner.centerYAnchor),
            commentTexfield.leadingAnchor.constraint(equalTo: commentOwner.trailingAnchor, constant: 12),
            commentTexfield.heightAnchor.constraint(equalToConstant: 30),
            commentTexfield.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            commentTexfield.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
        
        commentLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    
    func setupData(commentCount: String) {
        self.commentLabelCount.text = commentCount
    }
}
