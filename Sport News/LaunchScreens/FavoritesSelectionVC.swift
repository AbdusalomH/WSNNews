//
//  FavoritesSelectionVC.swift
//  Sport News
//
//  Created by Abdusalom on 29/06/2024.
//

import UIKit
import SkeletonView



protocol FavoriteListDelegate {
    func showMainViewTab()
}


final class FavoritesSelectionVC: UIViewController {
    
    
    var coordinator: AuthCoordinator?
    
    var categoriesData: [CategoriesModel] = []

    
    let favoriteTitle = WSNLabel(titleText: "Select your favorite sections to have us tailor the news to you",
                                 labelTextColor: .white,
                                 fontSize: 22,
                                 weight: .bold,
                                 numberOfLines: 0,
                                 textAlighment: .center)
    
    let favoriteSubTitle = WSNLabel(titleText: "A news feed will be formed for you, depending on the selected section",
                                    labelTextColor: .gray,
                                    fontSize: 16,
                                    weight: .semibold,
                                    numberOfLines: 0,
                                    textAlighment: .center)
    
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
    
    lazy var bottonContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.opacity = 0
        return view
    }()
    
    let proceedButton = WSNButton(title: "Proceed", 
                                  titleColor: .white,
                                  backgroundColor: .red)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationItem.hidesBackButton = true
        setupView()
        getCategories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    private func getCategories() {
        
        favoriteTable.showAnimatedSkeleton(usingColor: .darkGray)
        
        NetworkManager.shared.getCategories { result in
            switch result {
            case .success(let success):
                self.categoriesData = success
                DispatchQueue.main.async {
                    self.favoriteTable.stopSkeletonAnimation()
                    self.favoriteTable.hideSkeleton(transition: .crossDissolve(0.2))
                    self.favoriteTable.reloadData()
                }
            case .failure(let failure):
                print(failure)
            }
        }

    }
    
    
    private func setupView() {
        
        view.addSubview(favoriteTitle)
        view.addSubview(favoriteSubTitle)
        view.addSubview(favoriteTable)
        view.addSubview(bottonContainerView)
        bottonContainerView.addSubview(proceedButton)
        
        NSLayoutConstraint.activate([
            
            favoriteTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            favoriteTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            favoriteTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            favoriteTitle.heightAnchor.constraint(equalToConstant: 60),
            
            favoriteSubTitle.topAnchor.constraint(equalTo: favoriteTitle.bottomAnchor, constant: 12),
            favoriteSubTitle.leadingAnchor.constraint(equalTo: favoriteTitle.leadingAnchor, constant: 10),
            favoriteSubTitle.trailingAnchor.constraint(equalTo: favoriteTitle.trailingAnchor, constant: -10),
            favoriteSubTitle.heightAnchor.constraint(equalToConstant: 40),
            
            favoriteTable.topAnchor.constraint(equalTo: favoriteSubTitle.bottomAnchor, constant: 20),
            favoriteTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoriteTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favoriteTable.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            bottonContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10),
            bottonContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -10),
            bottonContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
            bottonContainerView.heightAnchor.constraint(equalToConstant: 120),
            
            proceedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            proceedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            proceedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            proceedButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        proceedButton.addTarget(self, action: #selector(navigateToMainVC), for: .touchUpInside)
        proceedButton.layer.opacity = 0
    }
    
    @objc func navigateToMainVC() {
        coordinator?.showMainTabBar()
    }
  
}


extension FavoritesSelectionVC: UICollectionViewDelegate, UICollectionViewDataSource, SkeletonCollectionViewDataSource {
    
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return FavoritesSelectionCell.reuseID
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesSelectionCell.reuseID, for: indexPath) as! FavoritesSelectionCell
        cell.setupContet(newItem: categoriesData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selection(checked: categoriesData[indexPath.row].followed_by_user, index: indexPath)
    }
    
    func selection(checked: Bool, index: IndexPath) {
        
        categoriesData[index.row].followed_by_user = !checked

        bottonContainerView.layer.opacity = categoriesData.contains(where: {$0.followed_by_user}) ? 1 : 0
        proceedButton.layer.opacity = categoriesData.contains(where: {$0.followed_by_user}) ? 1 : 0
        favoriteTable.reloadData()
    }
    
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
