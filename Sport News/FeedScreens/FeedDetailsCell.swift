//
//  FeedDetailsCell.swift
//  Sport News
//
//  Created by Abdusalom on 02/07/2024.
//

//FeedDetailsCell - ячейка каждой новости общая 


import UIKit
import Kingfisher
import SkeletonView

final class FeedDetailsCell: UITableViewCell {
    
    
    static let reuseID = "feedDetailsCells"
    
    lazy var channelTitle: UILabel = {
        let label       = UILabel()
        label.font      = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.backgroundColor = .black
        label.textColor = .white
        return label
    }()
    
    lazy var channelImage: UIImageView = {
        let image                   = UIImageView()
        image.contentMode           = .scaleAspectFill
        image.layer.cornerRadius    = 25
        image.clipsToBounds         = true
        
        return image
    }()
    
    lazy var durationMinutes: UILabel = {
        let label           = UILabel()
        label.font          = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor     = .lightGray
        return label
    }()
    
    lazy var feedImage: UIImageView = {
        let image                   = UIImageView()
        image.contentMode           = .scaleAspectFill
        image.layer.cornerRadius    = 10
        image.clipsToBounds         = true
        return image
    }()
    
    lazy var feedTextContainer: UIView = {
        let view                    = UIView()
        view.backgroundColor        = UIColor.black
        view.layer.opacity          = 0.5
        view.layer.cornerRadius     = 5
        view.layer.masksToBounds    = true
        return view
    }()
    
    let gradientContainer = GradientContainerView()
    
    lazy var feedText: UILabel = {
        let label           = UILabel()
        label.font          = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.numberOfLines = 0
        label.textColor     = .white
        return label
    }()
    
    lazy var likesIcon: UIImageView = {
        let image           = UIImageView()
        image.image         = UIImage(named: "likes")
        image.contentMode   = .scaleAspectFill
        return image
    }()
    
    lazy var likesCount: UILabel = {
        let label           = UILabel()
        label.textColor     = .white
        label.font          = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .left
        label.textColor     = .lightGray
        return label
    }()
    
    lazy var commentIcon: UIImageView = {
        let image           = UIImageView()
        image.contentMode   = .scaleAspectFill
        image.image         = UIImage(named: "comment")
        return image
    }()
    
    lazy var commentCount: UILabel = {
        let label            = UILabel()
        label.textColor      = .white
        label.textAlignment  = .left
        label.font           = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor      = .lightGray
        return label
    }()
    
    lazy var shareIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "share")
        return image
    }()
    
    lazy var addMark: UIButton = {
        let image = UIButton()
        image.setTitleColor(.lightGray, for: .normal)
        image.setTitleColor(.white, for: .selected)
        image.setTitleColor(.white, for: .highlighted)
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        isSkeletonable = true
        setupView()
        backgroundColor = .black
        contentView.backgroundColor = .black
        selectionStyle  = .none
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        let views = [channelTitle, channelImage, durationMinutes, feedImage, gradientContainer, feedText, likesIcon, likesCount, commentIcon, commentCount, shareIcon, addMark]

        for i in views {
            contentView.addSubview(i)
            i.translatesAutoresizingMaskIntoConstraints = false
            i.isSkeletonable = true
        }
        
        
        NSLayoutConstraint.activate([
            
            channelImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            channelImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            channelImage.heightAnchor.constraint(equalToConstant: 50),
            channelImage.widthAnchor.constraint(equalToConstant: 50),
            
            channelTitle.leadingAnchor.constraint(equalTo: channelImage.trailingAnchor, constant: 8),
            channelTitle.topAnchor.constraint(equalTo: channelImage.topAnchor),
            channelTitle.heightAnchor.constraint(equalToConstant: 20),
            channelTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            durationMinutes.leadingAnchor.constraint(equalTo: channelImage.trailingAnchor, constant: 8),
            durationMinutes.topAnchor.constraint(equalTo: channelTitle.bottomAnchor, constant: 8),
            durationMinutes.heightAnchor.constraint(equalToConstant: 12),
            durationMinutes.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            feedImage.topAnchor.constraint(equalTo: channelImage.bottomAnchor, constant: 12),
            feedImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            feedImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            feedImage.heightAnchor.constraint(equalTo: feedImage.widthAnchor),
            
            gradientContainer.bottomAnchor.constraint(equalTo: feedImage.bottomAnchor),
            gradientContainer.leadingAnchor.constraint(equalTo: feedImage.leadingAnchor),
            gradientContainer.trailingAnchor.constraint(equalTo: feedImage.trailingAnchor),
            gradientContainer.heightAnchor.constraint(equalTo: feedImage.heightAnchor, multiplier: 0.38),
            
            feedText.bottomAnchor.constraint(equalTo: feedImage.bottomAnchor, constant: -12),
            feedText.leadingAnchor.constraint(equalTo: feedImage.leadingAnchor, constant: 12),
            feedText.trailingAnchor.constraint(equalTo: feedImage.trailingAnchor, constant: -12),
            feedText.heightAnchor.constraint(equalTo: feedImage.heightAnchor, multiplier: 0.25),
            
            likesIcon.leadingAnchor.constraint(equalTo: feedImage.leadingAnchor, constant: 8),
            likesIcon.topAnchor.constraint(equalTo: feedImage.bottomAnchor, constant: 12),
            likesIcon.heightAnchor.constraint(equalToConstant: 26),
            likesIcon.widthAnchor.constraint(equalToConstant: 26),
            likesIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
    
            likesCount.centerYAnchor.constraint(equalTo: likesIcon.centerYAnchor),
            likesCount.leadingAnchor.constraint(equalTo: likesIcon.trailingAnchor, constant: 8),
            likesCount.heightAnchor.constraint(equalToConstant: 30),
            
            commentIcon.centerYAnchor.constraint(equalTo: likesIcon.centerYAnchor),
            commentIcon.leadingAnchor.constraint(equalTo: likesCount.trailingAnchor, constant: 12),
            commentIcon.heightAnchor.constraint(equalToConstant: 26),
            commentIcon.widthAnchor.constraint(equalToConstant: 26),
            
            commentCount.centerYAnchor.constraint(equalTo: likesIcon.centerYAnchor),
            commentCount.leadingAnchor.constraint(equalTo: commentIcon.trailingAnchor, constant: 8),
            commentCount.heightAnchor.constraint(equalToConstant: 30),
            
            shareIcon.leadingAnchor.constraint(equalTo: commentCount.trailingAnchor, constant: 20),
            shareIcon.topAnchor.constraint(equalTo: feedImage.bottomAnchor, constant: 12),
            shareIcon.heightAnchor.constraint(equalToConstant: 26),
            shareIcon.widthAnchor.constraint(equalToConstant: 26),
            
            addMark.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            addMark.centerYAnchor.constraint(equalTo: shareIcon.centerYAnchor),
            addMark.heightAnchor.constraint(equalToConstant: 26),
            addMark.widthAnchor.constraint(equalToConstant: 80)
        ])
       // channelTitle.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        likesCount.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        commentCount.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    
    func setupFeedData(datas: NewsModel) {
 
        self.channelTitle.text      = datas.source.title
        self.feedText.text          = datas.header
        self.likesCount.text        = ("\(datas.liked) likes")
        self.commentCount.text      = ("\(datas.commented)")
        self.durationMinutes.text   = timeAgoString(from: datas.createdAt)
        
        
        self.addMark.setImage(UIImage(resource: .mark), for: .normal)
        
        guard let url               = URL(string: datas.image) else {return}
        
        self.channelImage.kf.setImage(with: url)
        self.feedImage.kf.setImage(with: url)
        
    }
    
    
    private func timeAgoString(from dateString: String) -> String? {
        
        let dateFormatter   = ISO8601DateFormatter()
        
        guard let date      = dateFormatter.date(from: dateString) else { return nil }
        return date.timeAgoDisplay()
    }
}


