//
//  FollowVC.swift
//  Sport News
//
//  Created by Abdusalom on 30/06/2024.
//

import UIKit
import SkeletonView

final class FollowVC: UIViewController  {
    
 
    var categories: [CategoriesModel] = []
    var following: [String] = []
    
    let logo = WSNLogo(frame: .zero)
    
    lazy var titleContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()

    let sectionTitle = WSNLabel(titleText: "Follow",
                                 labelTextColor: .white,
                                 fontSize: 30,
                                 weight: .bold,
                                 numberOfLines: 0,
                                 textAlighment: .left)
    
    lazy var sectionsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add sectons", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.addTarget(self, action: #selector(tapSectionButton), for: .touchUpInside)
        button.backgroundColor = .black
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }()
    
    lazy var sectionBigButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(resource: .group92), for: .normal)
        button.addTarget(self, action: #selector(tapSectionButton), for: .touchUpInside)
        return button
    }()
    
    lazy var bigButtonTextBelow: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .gray
        label.textAlignment = .center
        label.text = "Add your first section"
        return label
    }()
    
    lazy var selectionText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.text = "The selection of the section determines the results of your the issue in the news feed"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .gray
        return label
    }()
    
    lazy var favoriteTable: UICollectionView = {
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.twoColumnsView(view: view))
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .black
        collection.register(FavoritesSelectionCell.self, forCellWithReuseIdentifier: FavoritesSelectionCell.reuseID)
        return collection
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteTable.reloadData()
        checkStatus()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func getFollowingCateogies() {
        NetworkManager.shared.followingUsersCategories { result in
            switch result {
            case .success(let success):
                self.categories = success
                DispatchQueue.main.async {
                    self.favoriteTable.reloadData()
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    private func setupView() {
        view.addSubview(titleContainer)
        view.addSubview(logo)
        view.addSubview(sectionTitle)
        view.addSubview(sectionsButton)
        view.addSubview(selectionText)
        view.addSubview(favoriteTable)
        view.addSubview(sectionBigButton)
        view.addSubview(bigButtonTextBelow)

        
        NSLayoutConstraint.activate([
            
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            logo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logo.heightAnchor.constraint(equalToConstant: 30),
            logo.widthAnchor.constraint(equalToConstant: 50),
            
            sectionTitle.centerYAnchor.constraint(equalTo: logo.centerYAnchor),
            sectionTitle.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 8),
            sectionTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            sectionTitle.heightAnchor.constraint(equalToConstant: 40),
            
            sectionsButton.centerYAnchor.constraint(equalTo: sectionTitle.centerYAnchor),
            sectionsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            sectionsButton.heightAnchor.constraint(equalToConstant: 30),
            sectionsButton.widthAnchor.constraint(equalToConstant: 120),
            
            selectionText.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 12),
            selectionText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            selectionText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            favoriteTable.topAnchor.constraint(equalTo: selectionText.bottomAnchor, constant: 8),
            favoriteTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoriteTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favoriteTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            
            sectionBigButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sectionBigButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            sectionBigButton.heightAnchor.constraint(equalToConstant: 150),
            sectionBigButton.widthAnchor.constraint(equalToConstant: 150),
            
            bigButtonTextBelow.topAnchor.constraint(equalTo: sectionBigButton.bottomAnchor, constant: 12),
            bigButtonTextBelow.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bigButtonTextBelow.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
        ])
        bigButtonTextBelow.setContentHuggingPriority(.defaultHigh, for: .vertical)
        selectionText.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    private func checkStatus() {
        
        selectionText.isHidden = categories.isEmpty
        favoriteTable.isHidden = categories.isEmpty
        sectionsButton.isHidden = categories.isEmpty
        sectionBigButton.isHidden = !categories.isEmpty
        
    }
    
    @objc func tapSectionButton() {
        tabBarController?.selectedIndex = 1
    }
 
}

extension FollowVC: UICollectionViewDelegate, UICollectionViewDataSource  {

    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesSelectionCell.reuseID, for: indexPath) as! FavoritesSelectionCell
        cell.setupContentForFavorites(fav: categories[indexPath.row])
        return cell
    }
    
}
