//
//  FeedVC.swift
//  Sport News
//
//  Created by Abdusalom on 30/06/2024.
//


//FeedVC - Общий таблица для всех категории

import UIKit
import SkeletonView

protocol GetNextNewsDelegate: AnyObject {
    func getNextNews()
}

final class FeedVC: UIViewController {
    
    var coordinator: FeedCoordinator?
    
    let newsNetwork = NewsNetworkManager()
    
    var page = 1
    
    var hasMoreNews = true
    
    var firstLaunch = true
        
    var categoryData: [String] = []
    
    var groupedCategory: [String : [NewsModel]] = [:]
        
    let logo = WSNLogo(frame: .zero)

    lazy var titleContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    let feedTitleLabel = WSNLabel(titleText: "World Sport News",
                                 labelTextColor: .white,
                                 fontSize: 30,
                                 weight: .black,
                                 numberOfLines: 1,
                                 textAlighment: .left)
    
    lazy var categoriesTable: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: categoryflowlayut())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .black
        collection.register(FeedCategoryCell.self, forCellWithReuseIdentifier: FeedCategoryCell.reuseID)
        collection.isSkeletonable = true
        return collection
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
    lazy var feedTable: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: feedflowlayut())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .black
        collection.register(FeedCell.self, forCellWithReuseIdentifier: FeedCell.reuseID)
        collection.isPagingEnabled = true
        collection.isHidden = true
        return collection
    }()
    
    lazy var feedSkeletonTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .black
        table.register(FeedDetailsCell.self, forCellReuseIdentifier: FeedDetailsCell.reuseID)
        table.isSkeletonable = true
        return table
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        getNewViaRouter(pageIndex: page)
    }

    
    func getNewViaRouter(pageIndex: Int) {
        
        if hasMoreNews {
            feedSkeletonTable.showAnimatedSkeleton(usingColor: .darkGray)
            categoriesTable.showAnimatedSkeleton(usingColor: .darkGray)
        }
        
        
        var receivedCategory: Set<String> = []
        
        var grouped: [String: [NewsModel]] = [:]
        
        
        newsNetwork.getNews(index: pageIndex) { newsModel, error in
            
            guard let newsdata = newsModel else { return }
            
            if self.hasMoreNews {
                for item in newsdata {
                    let category = item.source.title
                    if !receivedCategory.contains(category) {
                        receivedCategory.insert(category)
                    }
                    
                    if grouped[category] == nil {
                        grouped[category] = []
                    }
                    grouped[category]?.append(item)
                }
                
                DispatchQueue.main.async {
                    self.categoryData = Array(receivedCategory)
                    if self.categoryData.count < 100 {
                        
                    }
                    for (category, items) in grouped {
                        if self.groupedCategory[category] == nil {
                            self.groupedCategory[category] = items
                        } else {
                            self.groupedCategory[category]?.append(contentsOf: items)
                        }
                    }
                    //Hide skeleton cross dissolve transition with 0.25 seconds fade time
                    UIView.animate(withDuration: 0.1) {
                        self.categoriesTable.stopSkeletonAnimation()
                        self.categoriesTable.hideSkeleton(transition: .crossDissolve(0.25))
                        self.feedSkeletonTable.stopSkeletonAnimation()
                        self.feedSkeletonTable.hideSkeleton(transition: .crossDissolve(0.25))
                        self.feedSkeletonTable.isHidden = true
                        self.feedTable.isHidden = false
                        self.categoriesTable.reloadData()
                        self.feedTable.reloadData()
                        
                    }
                }
            }
            
            
            if newsdata.count < 100 {
                
                self.hasMoreNews = false
                
            }
        }
    }


    func viewSetup() {
        
        view.backgroundColor = .black
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.addSubview(titleContainer)
        
        titleContainer.addSubview(logo)
        titleContainer.addSubview(feedTitleLabel)
        
        view.addSubview(categoriesTable)
        view.addSubview(feedTable)
        view.addSubview(lineView)
        view.addSubview(feedSkeletonTable)
        
        NSLayoutConstraint.activate([
            
            titleContainer.topAnchor.constraint(equalTo: view.topAnchor),
            titleContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleContainer.heightAnchor.constraint(equalToConstant: 120),
            
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            logo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logo.heightAnchor.constraint(equalToConstant: 30),
            logo.widthAnchor.constraint(equalToConstant: 50),
            
            feedTitleLabel.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 12),
            feedTitleLabel.centerYAnchor.constraint(equalTo: logo.centerYAnchor),
            feedTitleLabel.heightAnchor.constraint(equalToConstant: 50),
            feedTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            categoriesTable.topAnchor.constraint(equalTo: titleContainer.bottomAnchor),
            categoriesTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categoriesTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            categoriesTable.heightAnchor.constraint(equalToConstant: 50),
            
            lineView.topAnchor.constraint(equalTo: categoriesTable.bottomAnchor, constant: -3),
            lineView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 2),
            
            feedTable.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 12),
            feedTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            feedTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            feedTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            feedSkeletonTable.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 12),
            feedSkeletonTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            feedSkeletonTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            feedSkeletonTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}


extension FeedVC: UICollectionViewDelegate, UICollectionViewDataSource, SkeletonCollectionViewDataSource, SkeletonTableViewDelegate  {

  
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        switch skeletonView {
        case categoriesTable:
            return FeedCategoryCell.reuseID
        case feedTable:
            return FeedCell.reuseID
        default:
            break
        }
        return ""
    }

    
    
    //Количество ячеек на новостной ленте одинакого с ячейками категории
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case categoriesTable:
            return categoryData.count
        case feedSkeletonTable:
            return categoryData.count
        case feedTable:
            return categoryData.count
        default:
            break
        }
        return 0
    }
    
    
    //Выбираем ячейку с категории и переходим на вкладку новостей соотвественно выбору!
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        switch collectionView {
        case categoriesTable:
            scrollToSelectedSection(row: indexPath.row)
            feedTable.isPagingEnabled = true
        default:
            break
        }
    }

    
    // Инициализация простая, для первой ячейки категории сразу ставим выбор как активная
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let keyArray = Array(groupedCategory.keys)

        switch collectionView {
 
            
        case categoriesTable:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCategoryCell.reuseID, for: indexPath) as! FeedCategoryCell
            let receivedCategory = keyArray[indexPath.row]
           
            cell.setupData(name: receivedCategory)
            if firstLaunch {
                let index = IndexPath(row: 0, section: 0)
                categoriesTable.selectItem(at: index, animated: true, scrollPosition: .left)
                firstLaunch.toggle()
            }
            return cell
           
            
        case feedTable:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCell.reuseID, for: indexPath) as! FeedCell
            cell.delegates = self
            cell.getNextNews = self
            let category = Array(groupedCategory.keys)[indexPath.item]
            let newsItems = groupedCategory[category] ?? []
            cell.setupData(name: category, newsData: newsItems)
            return cell
            
        default:
            break
        }
        return UICollectionViewCell()
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        switch scrollView {
        case feedTable:
            let index = Int(scrollView.contentOffset.x / view.frame.width)
            let indexpath = IndexPath(row: index, section: 0)
            categoriesTable.selectItem(at: indexpath, animated: true, scrollPosition: .centeredHorizontally)
            categoriesTable.scrollToItem(at: indexpath, at: .centeredHorizontally, animated: true)
        default:
            break
        }
    }
    
    
    func scrollToSelectedSection(row: Int) {
        let index = IndexPath(row: row, section: 0)
        feedTable.isPagingEnabled = false
        feedTable.scrollToItem(at: index, at: .centeredVertically, animated: true)
        feedTable.selectItem(at: index, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    
    func categoryflowlayut() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return flowLayout
    }
    
    
    func feedflowlayut() -> UICollectionViewFlowLayout {
        let padding: CGFloat = 0
        let flowlayut = UICollectionViewFlowLayout()
        flowlayut.minimumLineSpacing = 0
        flowlayut.scrollDirection = .horizontal
        flowlayut.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowlayut.itemSize = CGSize(width: view.bounds.width, height: view.bounds.height - 190)
        return flowlayut
    }
}


extension FeedVC: FeedCellDelegate, GetNextNewsDelegate  {
    
    func didTapNewsDetail(data: Int) {
        let vc = NewsDetailsVCCell(newsId: data)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func getNextNews() {
        page += 1
        getNewViaRouter(pageIndex: page)
    }
}


extension FeedVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedDetailsCell.reuseID, for: indexPath) as! FeedDetailsCell
        cell.showAnimatedSkeleton(usingColor: .darkGray)
        return cell
    }
}
