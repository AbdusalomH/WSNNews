//
//  SectionsVC.swift
//  Sport News
//
//  Created by Abdusalom on 30/06/2024.
//

import UIKit
import SkeletonView
import Combine

struct CategoryModel {
    let id: Int
    let title: String
    let image: String
    var followed_by_user: Bool
}

final class SectionsVC: UIViewController {
    
    var viewmodel = SectionsViewModel()
    var cancellables = Set<AnyCancellable>()
    
    
    
    var categoryData: [CategoriesModel] = []

    var isSelected = false

    let logo = WSNLogo(frame: .zero)
    
    let sectionTitle = WSNLabel(titleText: "Sections",
                                 labelTextColor: .white,
                                 fontSize: 30,
                                 weight: .bold,
                                 numberOfLines: 0,
                                 textAlighment: .left)

    lazy var favoriteTable: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowlayut())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .black
        collection.register(FavoritesSelectionCell.self, forCellWithReuseIdentifier: FavoritesSelectionCell.reuseID)
        collection.isSkeletonable = true
        return collection
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupView()
        navigationController?.setNavigationBarHidden(true, animated: true)
        getFavorites()
    }
    
    
    
    private func getFavorites() {
        
        favoriteTable.showAnimatedSkeleton(usingColor: .darkGray)
        
        NetworkManager.shared.getCategories { result in
            switch result {
            case .success(let success):
                self.categoryData = success
                DispatchQueue.main.async {
                    self.favoriteTable.stopSkeletonAnimation()
                    self.favoriteTable.hideSkeleton(transition: .crossDissolve(0.2))
                    self.favoriteTable.reloadData()
                }
            case .failure(let failure):
                print(failure)
                self.presentWSNAlertOnMainThread(title: "Warnign", message: "Please try again later", actionTitle: "OK")
            }
        }
    }
    
    private func setupView() {
        
        view.addSubview(logo)
        view.addSubview(sectionTitle)
        view.addSubview(favoriteTable)

        NSLayoutConstraint.activate([
            
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            logo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logo.heightAnchor.constraint(equalToConstant: 30),
            logo.widthAnchor.constraint(equalToConstant: 50),
            
            sectionTitle.centerYAnchor.constraint(equalTo: logo.centerYAnchor),
            sectionTitle.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 8),
            sectionTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            sectionTitle.heightAnchor.constraint(equalToConstant: 40),
            
            favoriteTable.topAnchor.constraint(equalTo: sectionTitle.bottomAnchor, constant: 20),
            favoriteTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoriteTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favoriteTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
        ])
    }
    
    private func selection(checked: Bool, index: IndexPath) {
        categoryData[index.row].followed_by_user = !checked
         favoriteTable.reloadData()

    }
}



//Configure Table View
extension SectionsVC: UICollectionViewDelegate, UICollectionViewDataSource, SkeletonCollectionViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return FavoritesSelectionCell.reuseID
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesSelectionCell.reuseID, for: indexPath) as! FavoritesSelectionCell
        cell.setupContet(newItem: categoryData[indexPath.row])
        //selection(checked: self.categoryData[indexPath.row].followed_by_user, index: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        NetworkManager.shared.addFavoriteCategory(id: categoryData[indexPath.row].id) { result in
            switch result {
            case .success(let success):
                self.presentWSNAlertOnMainThread(title: "Favorites", message: "\(success.result)", actionTitle: "OK")
                DispatchQueue.main.async {
                    self.favoriteTable.reloadData()
                    self.selection(checked: self.categoryData[indexPath.row].followed_by_user, index: indexPath)
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
}



//Configure FLowlayout

extension SectionsVC {
    
    func flowlayut() -> UICollectionViewFlowLayout {
        
        let width = view.bounds.width
        let padding: CGFloat = 10
        let minimumSpacing: CGFloat = 10
        let availableWidth = width - (2 * padding) - minimumSpacing
        let cellWidth = availableWidth / 2
        
        let flawlayout = UICollectionViewFlowLayout()
        flawlayout.scrollDirection = .vertical
        flawlayout.minimumLineSpacing = minimumSpacing
        flawlayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        
        flawlayout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        return flawlayout
    }
    
}


