//
//  FeedCell.swift
//  Sport News
//
//  Created by Abdusalom on 30/06/2024.
//

//FeedCell - Таблица для всех ячеек коллекции

import UIKit

protocol FeedCellDelegate: AnyObject {
    func didTapNewsDetail(data: Int)
}


final class FeedCell: UICollectionViewCell {

    weak var getNextNews: GetNextNewsDelegate?
    
    var delegates: FeedCellDelegate?
    
    static let reuseID = "feedListCell"
    
    var receivedNewsModel: [NewsModel] = []
 
    
    lazy var feedsTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .black
        table.register(FeedDetailsCell.self, forCellReuseIdentifier: FeedDetailsCell.reuseID)
        return table
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        contentView.backgroundColor = .black

        contentView.addSubview(feedsTable)
        
        NSLayoutConstraint.activate([
            feedsTable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            feedsTable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            feedsTable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            feedsTable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50)
        ])
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupData(name: String, newsData: [NewsModel]) {
        receivedNewsModel = newsData
    }
    
    
    @objc func addNewItem(sender: UIButton) {
        feedsTable.reloadData()
    }
}

extension FeedCell: UITableViewDataSource, UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receivedNewsModel.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedDetailsCell.reuseID, for: indexPath) as! FeedDetailsCell
        
        cell.setupFeedData(datas: receivedNewsModel[indexPath.row])
        cell.addMark.tag = indexPath.row
        cell.addMark.addTarget(self, action: #selector(addNewItem(sender:)), for: .touchUpInside)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegates?.didTapNewsDetail(data: receivedNewsModel[indexPath.row].id)
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY          = scrollView.contentOffset.y
        let contentHeight    = scrollView.contentSize.height
        let height           = scrollView.frame.size.height
        
        if offsetY > contentHeight - height{
            getNextNews?.getNextNews()
        }
    }
}
