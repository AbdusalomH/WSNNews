//
//  NewsDetailsVC.swift
//  Sport News
//
//  Created by Abdusalom on 05/07/2024.
//

// NewsDetailsVC - Таблица детали новости и других общих новостей включая переход на комменты



import UIKit
import SafariServices
import SkeletonView



class NewsDetailsVCCell: UIViewController {
    
    var newsId: Int
    var newsDetails: NewsModelDetails?
    var anotherNews: [NewsModel] = []
    
    
    init(newsId: Int) {
        self.newsId = newsId
        super.init(nibName: nil, bundle: nil)
    }
    
    
    lazy var feedDetailTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(NewsDetailsCell.self, forCellReuseIdentifier: NewsDetailsCell.reuseID)
        table.register(FeedDetailsCell.self, forCellReuseIdentifier: FeedDetailsCell.reuseID)
        table.register(FeedDetailCommentCell.self, forCellReuseIdentifier: FeedDetailCommentCell.reuseID)
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .black
        table.isSkeletonable = true
        table.estimatedSectionHeaderHeight = 0
        table.estimatedSectionFooterHeight = 0
        table.separatorStyle = .none
        return table
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let netRoute = NewsNetworkManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupVew()
        getDetails(newsID: newsId)
        getAllFeed()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.feedDetailTable.stopSkeletonAnimation()
        self.feedDetailTable.hideSkeleton(transition: .crossDissolve(0.2))
        self.feedDetailTable.reloadData()
    }
    
    
    func getAllFeed() {
        let gradient = SkeletonGradient(baseColor: .darkGray)
        self.feedDetailTable.startSkeletonAnimation()
        self.feedDetailTable.showAnimatedGradientSkeleton(usingGradient: gradient)
        
        netRoute.getNews(index: 1) { newsModel, error in
            guard let receviedNews = newsModel else { return }
            self.anotherNews = receviedNews
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.feedDetailTable.stopSkeletonAnimation()
                self.feedDetailTable.hideSkeleton(transition: .crossDissolve(0.2))
                self.feedDetailTable.reloadData()
            }
        }
    }
    
    
    
    
    func getDetails(newsID: Int) {
        
        netRoute.getNewsDetails(id: newsID) { newsDetailsMode, error in
            
            guard let details = newsDetailsMode else { return }
            
            self.newsDetails = details
        }
    }
    
    
    // Setup UI Table
    private func setupVew() {
        
        view.addSubview(feedDetailTable)
        
        NSLayoutConstraint.activate([
            feedDetailTable.topAnchor.constraint(equalTo: view.topAnchor, constant: -60),
            feedDetailTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            feedDetailTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            feedDetailTable.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90),
        ])
    }
    
    @objc func addFavotire(sender: UIButton) {
        

    }
    
    // Navigate to back
    @objc func backTapped() {
        navigationController?.popViewController(animated: true)
    }
}


//All delegates
extension NewsDetailsVCCell: NewsDetailsCellDelegate, CommentDetailCellDelegate, CellDelegateForUrl  {
    
    
    func didTapToComment(id: Int) {
        navigationController?.pushViewController(CommentVC(newsID: id), animated: true)
    }
    
    
    func didTapButton(url: URL) {
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
 
    
    func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
}

//Configure UI Tables
extension NewsDetailsVCCell: UITableViewDelegate, UITableViewDataSource, SkeletonTableViewDataSource, SkeletonTableViewDelegate {
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        switch indexPath.row {
        case 0:
            return NewsDetailsCell.reuseID
        case 1:
            return FeedDetailCommentCell.reuseID
        default:
            return FeedDetailsCell.reuseID
        }
    }
    
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0, 1:
            return newsDetails != nil ? 1 : 0
        case 2:
            return anotherNews.isEmpty ? 0 : anotherNews.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let newsDetailsdata = newsDetails else { 
            return UITableViewCell()
        }
        
        
        switch indexPath.section {
            
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsDetailsCell.reuseID, for: indexPath) as! NewsDetailsCell
            cell.delegate = self
            cell.setupViewData(data: newsDetailsdata)
            cell.selectionStyle = .none
            cell.commentDelegate = self
            cell.cellDelegateUrl = self
            cell.contentView.backgroundColor = .black
            cell.commentIcon.tag = newsDetailsdata.id
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: FeedDetailCommentCell.reuseID, for: indexPath) as! FeedDetailCommentCell
            cell.setupData(commentCount: "\(newsDetailsdata.commented)")
            cell.contentView.backgroundColor = .black
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: FeedDetailsCell.reuseID, for: indexPath) as! FeedDetailsCell
            cell.addMark.tag = indexPath.row
            cell.addMark.addTarget(self, action: #selector(addFavotire(sender: )), for: .touchUpInside)
            cell.contentView.backgroundColor = .black
            cell.setupFeedData(datas: anotherNews[indexPath.row])
            return cell
        default:
            fatalError("fatal error")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 1:
            navigationController?.pushViewController(CommentVC(newsID: anotherNews[indexPath.row].id), animated: true)
        case 2...:
            navigationController?.pushViewController(NewsDetailsVCCell(newsId: anotherNews[indexPath.row].id), animated: true)
        default:
            break
        }
    }
}
