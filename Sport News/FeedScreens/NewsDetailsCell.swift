//
//  NewsDetailsМС.swift
//  Sport News
//
//  Created by Abdusalom on 03/07/2024.
//

//NewsDetailsCell - ячейка для подробной новости


import UIKit
import Kingfisher
import SafariServices
import SkeletonView

protocol NewsDetailsCellDelegate: AnyObject {
    func didTapBackButton()
}

protocol CommentDetailCellDelegate: AnyObject {
    func didTapToComment(id: Int)
}

protocol ReloadTableDelegate: AnyObject {
    func reloadTable()
}

protocol CellDelegateForUrl: AnyObject {
    func didTapButton(url: URL)
}



class NewsDetailsCell: UITableViewCell {
    
    
    var openedNews: NewsModelDetails?
    
    var navigationURL: String?
    
    static let reuseID = "newsDetailsCell"
    
    weak var delegate: NewsDetailsCellDelegate?
    weak var commentDelegate: CommentDetailCellDelegate?
    weak var cellDelegateUrl: CellDelegateForUrl?
    
    
    lazy var feedImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var channelTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    lazy var channelImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 25
        image.clipsToBounds = true
        return image
    }()
    
    lazy var durationMinutes: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .lightGray
        return label
    }()
    
    let gradientContainer = GradientContainerView()
    
    lazy var feedText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.numberOfLines = 4
        label.textColor = .white
        label.backgroundColor = .black
        return label
    }()
    
    lazy var feedTextDetails: UILabel  = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 0
        label.textColor = .gray
        label.backgroundColor = .black
        return label
    }()
    
    lazy var likesIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "likes")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var likesCount: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .left
        label.textColor = .lightGray
        return label
    }()
    
    lazy var shareLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .left
        label.text = "Share"
        return label
    }()
    
    lazy var commentIcon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "comment")
        return image
    }()
    
    lazy var commentCount: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .lightGray
        return label
    }()
    
    lazy var shareIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "share")
        return image
    }()
    
    lazy var addMark: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(addToFavorite), for: .touchUpInside)
        return button
    }()
    
    lazy var backImage: UIButton = {
        let backButton = UIButton()
        backButton.setImage(UIImage(named: "Back"), for: .normal)
        backButton.layer.cornerRadius = 20
        backButton.contentMode = .scaleAspectFill
        backButton.tintColor = .black
        backButton.layer.shadowColor = UIColor.darkGray.cgColor
        backButton.layer.shadowRadius = 10
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return backButton
    }()
    
    lazy var readMore: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Read More", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        button.layer.cornerRadius = 5
        button.backgroundColor = #colorLiteral(red: 0.1215686426, green: 0.1215686426, blue: 0.1215686426, alpha: 1)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(readmoreTapped), for: .touchUpInside)
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        isSkeletonable = true
        backgroundColor = .black
        contentView.backgroundColor = .black
        
        setupCellView()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        contentView.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    @objc func readmoreTapped() {
        print("tapped read more")
        guard let url = URL(string: navigationURL ?? "") else {return}
        cellDelegateUrl?.didTapButton(url: url)
    }

    @objc func openCommentTapped() {
        let id = commentIcon.tag
        commentDelegate?.didTapToComment(id: id)
    }

    @objc func backTapped() {
        delegate?.didTapBackButton()
    }

    @objc func dismissKeyboard() {
        contentView.endEditing(true)
    }
    
    @objc func addToFavorite() {

    }

 
    func setupCellView() {
        
        let cellViews = [feedImage, gradientContainer, channelImage, channelTitle, durationMinutes, feedText, feedTextDetails, likesIcon, likesCount, commentIcon, commentCount, shareIcon, addMark, backImage, shareLabel, readMore]
        
        feedImage.isSkeletonable = true
        channelImage.isSkeletonable = true
        channelTitle.isSkeletonable = true
        durationMinutes.isSkeletonable = true
        feedText.isSkeletonable = true
        //likesIcon.isSkeletonable = true
       // shareIcon.isSkeletonable = true
        addMark.isSkeletonable = true
        //shareLabel.isSkeletonable = true
        //commentIcon.isSkeletonable = true
        
        for i in cellViews {
            i.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(i)
        }
        
        NSLayoutConstraint.activate([

            feedImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            feedImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            feedImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            feedImage.heightAnchor.constraint(equalToConstant: 350),
            feedImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -210),
            
            gradientContainer.bottomAnchor.constraint(equalTo: feedImage.bottomAnchor),
            gradientContainer.leadingAnchor.constraint(equalTo: feedImage.leadingAnchor),
            gradientContainer.trailingAnchor.constraint(equalTo: feedImage.trailingAnchor),
            gradientContainer.heightAnchor.constraint(equalTo: feedImage.heightAnchor, multiplier: 0.38),
            
            channelImage.leadingAnchor.constraint(equalTo: feedImage.leadingAnchor, constant: 12),
            channelImage.bottomAnchor.constraint(equalTo: feedImage.bottomAnchor, constant: -5),
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
            
            
            backImage.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 65),
            backImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            backImage.heightAnchor.constraint(equalToConstant: 38),
            backImage.widthAnchor.constraint(equalToConstant: 38),
            
            feedText.topAnchor.constraint(equalTo: gradientContainer.bottomAnchor),
            feedText.leadingAnchor.constraint(equalTo: feedImage.leadingAnchor, constant: 12),
            feedText.trailingAnchor.constraint(equalTo: feedImage.trailingAnchor, constant: -12),
            feedText.heightAnchor.constraint(equalToConstant: 60),
            
            feedTextDetails.topAnchor.constraint(equalTo: feedText.bottomAnchor, constant: 8),
            feedTextDetails.leadingAnchor.constraint(equalTo: feedImage.leadingAnchor, constant: 12),
            feedTextDetails.trailingAnchor.constraint(equalTo: feedImage.trailingAnchor, constant: -12),
            feedTextDetails.heightAnchor.constraint(equalToConstant: 80),
            
            readMore.topAnchor.constraint(equalTo: feedTextDetails.bottomAnchor, constant: -8),
            readMore.leadingAnchor.constraint(equalTo: feedTextDetails.leadingAnchor),
            readMore.trailingAnchor.constraint(equalTo: feedTextDetails.trailingAnchor),
            readMore.heightAnchor.constraint(equalToConstant: 40),
            
            likesIcon.leadingAnchor.constraint(equalTo: readMore.leadingAnchor),
            likesIcon.topAnchor.constraint(equalTo: readMore.bottomAnchor, constant: 8),
            likesIcon.heightAnchor.constraint(equalToConstant: 26),
            likesIcon.widthAnchor.constraint(equalToConstant: 26),
    
            likesCount.centerYAnchor.constraint(equalTo: likesIcon.centerYAnchor),
            likesCount.leadingAnchor.constraint(equalTo: likesIcon.trailingAnchor, constant: 8),
            likesCount.heightAnchor.constraint(equalToConstant: 30),
            
            commentIcon.centerYAnchor.constraint(equalTo: likesIcon.centerYAnchor),
            commentIcon.leadingAnchor.constraint(equalTo: likesCount.trailingAnchor, constant: 12),
            commentIcon.heightAnchor.constraint(equalToConstant: 26),
            commentIcon.widthAnchor.constraint(equalToConstant: 26),
            
            commentCount.centerYAnchor.constraint(equalTo: likesIcon.centerYAnchor),
            commentCount.leadingAnchor.constraint(equalTo: commentIcon.trailingAnchor, constant: 8),
            commentCount.heightAnchor.constraint(equalToConstant: 26),

            shareIcon.leadingAnchor.constraint(equalTo: commentCount.trailingAnchor, constant: 8),
            shareIcon.centerYAnchor.constraint(equalTo: commentCount.centerYAnchor),
            shareIcon.heightAnchor.constraint(equalToConstant: 26),
            shareIcon.widthAnchor.constraint(equalToConstant: 26),
            
            shareLabel.leadingAnchor.constraint(equalTo: shareIcon.trailingAnchor, constant: 8),
            shareLabel.centerYAnchor.constraint(equalTo: shareIcon.centerYAnchor),
            shareLabel.heightAnchor.constraint(equalToConstant: 26),
            
            addMark.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            addMark.centerYAnchor.constraint(equalTo: shareIcon.centerYAnchor),
            addMark.heightAnchor.constraint(equalToConstant: 26),
        ])
        
        shareLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        commentCount.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
    }
    
    
    func setupViewData(data: NewsModelDetails) {

        self.channelTitle.text = data.source.category.title
        self.feedText.text = data.header
        self.feedTextDetails.text = data.text
        self.likesCount.text = "\(data.liked)"
        self.commentCount.text = "\(data.commented)"
        self.durationMinutes.text = timeAgoString(from: data.createdAt)
                
        addMark.setImage(UIImage(resource: .mark) , for: .normal)
        self.navigationURL = data.link
        guard let url = URL(string: data.image) else {return}
        guard let categoryImage = URL(string: data.source.category.image ?? "") else {return}
        
        self.feedImage.kf.setImage(with: url, placeholder: UIImage(resource: .blacks))
        self.channelImage.kf.setImage(with: categoryImage, placeholder: UIImage(resource: .blacks))
        

    }
    
    
    private func timeAgoString(from dateString: String) -> String? {
        let dateFormatter = ISO8601DateFormatter()
        guard let date = dateFormatter.date(from: dateString) else { return nil }
        return date.timeAgoDisplay()
    }
}
