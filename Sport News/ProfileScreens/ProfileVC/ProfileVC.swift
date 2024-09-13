//
//  ProfileVC.swift
//  Sport News
//
//  Created by Abdusalom on 21/07/2024.
//

import UIKit

class ProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    var profileCoordinator: ProfileCoordinator?
    
    //var favoriteFeeds = MockDataHere.favoriteList
    
    var following: [CategoriesModel] = []
    
    let logo = WSNLogo(frame: .zero)
    
    lazy var screenTitle: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .white
        title.font = .systemFont(ofSize: 30, weight: .bold)
        title.text = "Profile"
        title.textAlignment = .left
        title.numberOfLines = 1
        title.minimumScaleFactor = 0.5
        return title
    }()
    
    lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Settings", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.setTitleColor(.gray, for: .highlighted)
        button.addTarget(self, action: #selector(showSettings), for: .touchUpInside)
        button.backgroundColor = .black
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }()
    
    lazy var userInfoContainer: UIView = {
        let userInfo = UIView()
        userInfo.translatesAutoresizingMaskIntoConstraints = false
        userInfo.backgroundColor = #colorLiteral(red: 0.1098039076, green: 0.1098039076, blue: 0.1098039076, alpha: 1)
        userInfo.layer.cornerRadius = 10
        userInfo.clipsToBounds = true
        return userInfo
    }()
    
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .white
        label.text = "John Wilson"
        return label
    }()
    
    
    lazy var usernameImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.image = UIImage(systemName: "person.circle.fill")
        image.tintColor = .gray
        return image
    }()
    
    
    lazy var usernameEmail: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .gray
        label.text = "john@gmail.com"
        return label
    }()
    
    
    lazy var uisegment: UISegmentedControl = {
        let segment = UISegmentedControl()
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.insertSegment(withTitle: "Favorites", at: 0, animated: true)
        segment.insertSegment(withTitle: "Following", at: 1, animated: true)
        segment.backgroundColor = .red
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(changedValue), for: .valueChanged)
        
        
        // Устанавливаем цвет текста для нормального состояния
        segment.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)

        // Устанавливаем цвет текста для выбранного состояния
        segment.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)

        return segment
    }()
    
    
    lazy var favoriteTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .black
        table.register(FeedDetailsCell.self, forCellReuseIdentifier: FeedDetailsCell.reuseID)
        return table
    }()
    
    
    lazy var followingTable: UICollectionView = {
        let table = UICollectionView(frame: .zero, collectionViewLayout: flowlayut())
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(FavoritesSelectionCell.self, forCellWithReuseIdentifier: FavoritesSelectionCell.reuseID)
        table.backgroundColor = .black
        table.isHidden = true
        return table
        
    }()
    
    
    lazy var logOutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func logoutTapped() {
        
        let alert = UIAlertController(title: "Do you want to log out?", message: "All saved data will be removed", preferredStyle: .alert)
        
        
        let action = UIAlertAction(title: "Log Out", style: .default) { _ in
            KeychainManager.shared.removedAll()
            self.usernameLabel.text = "Username"
            self.usernameEmail.text = "email"
            MockDataHere.selectedContent.removeAll()
            self.profileCoordinator?.start()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(action)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupView()
        
        let userInfo = KeychainManager.shared.getUserInfo()
        let username = userInfo.username ?? "Not available"
        let email = userInfo.email ?? "Not available"
        
        usernameLabel.text = username
        usernameEmail.text = email
        
        NetworkManager.shared.getCategories { result in
            switch result {
            case .success(let success):
                self.following = success
                DispatchQueue.main.async {
                    self.followingTable.reloadData()
                }
            case .failure(let failure):
                print(failure)
            }
        }
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        favoriteTable.reloadData()
        followingTable.reloadData()
    }

    
    private func setupView() {
        view.addSubview(logo)
        view.addSubview(screenTitle)
        view.addSubview(settingsButton)
        view.addSubview(userInfoContainer)
        view.addSubview(uisegment)
        view.addSubview(favoriteTable)
        view.addSubview(followingTable)
        view.addSubview(logOutButton)
        
        userInfoContainer.addSubview(usernameLabel)
        userInfoContainer.addSubview(usernameImage)
        userInfoContainer.addSubview(usernameEmail)
        
        
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            logo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logo.heightAnchor.constraint(equalToConstant: 30),
            logo.widthAnchor.constraint(equalToConstant: 60),
            
            settingsButton.centerYAnchor.constraint(equalTo: logo.centerYAnchor),
            settingsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            settingsButton.heightAnchor.constraint(equalToConstant: 30),
            settingsButton.widthAnchor.constraint(equalToConstant: 80),
            
            screenTitle.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 12),
            screenTitle.centerYAnchor.constraint(equalTo: logo.centerYAnchor),
            screenTitle.heightAnchor.constraint(equalToConstant: 60),
            screenTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            userInfoContainer.topAnchor.constraint(equalTo: screenTitle.bottomAnchor, constant: 20),
            userInfoContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            userInfoContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            userInfoContainer.heightAnchor.constraint(equalToConstant: 90),
            
            usernameImage.centerYAnchor.constraint(equalTo: userInfoContainer.centerYAnchor),
            usernameImage.leadingAnchor.constraint(equalTo: userInfoContainer.leadingAnchor, constant: 12),
            usernameImage.heightAnchor.constraint(equalToConstant: 60),
            usernameImage.widthAnchor.constraint(equalToConstant: 60),
            
            usernameLabel.topAnchor.constraint(equalTo: usernameImage.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: usernameImage.trailingAnchor, constant: 12),
            usernameLabel.heightAnchor.constraint(equalToConstant: 26),
            
            usernameEmail.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8),
            usernameEmail.leadingAnchor.constraint(equalTo: usernameImage.trailingAnchor, constant: 12),
            usernameEmail.heightAnchor.constraint(equalToConstant: 16),
            
            uisegment.topAnchor.constraint(equalTo: userInfoContainer.bottomAnchor, constant: 12),
            uisegment.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            uisegment.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            uisegment.heightAnchor.constraint(equalToConstant: 50),
            
            favoriteTable.topAnchor.constraint(equalTo: uisegment.bottomAnchor, constant: 8),
            favoriteTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            favoriteTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            favoriteTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            
            followingTable.topAnchor.constraint(equalTo: uisegment.bottomAnchor),
            followingTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            followingTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            followingTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            
            logOutButton.trailingAnchor.constraint(equalTo: userInfoContainer.trailingAnchor, constant: -8),
            logOutButton.topAnchor.constraint(equalTo: userInfoContainer.topAnchor, constant: 8),
            logOutButton.heightAnchor.constraint(equalToConstant: 22)
        ])
        
        usernameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        usernameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        usernameEmail.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        logOutButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    
    @objc func changedValue() {
        favoriteTable.reloadData()
        followingTable.reloadData()
        animateTables()
        
    }
    
    @objc func showSettings() {
        profileCoordinator?.showSettingProfile()
    }

    
    func animateTables() {
        if uisegment.selectedSegmentIndex == 0 {
            followingTable.isHidden = true
            favoriteTable.isHidden = false
        } else {
            followingTable.isHidden = false
            favoriteTable.isHidden = true
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return MockDataHere.favoriteList.count
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedDetailsCell.reuseID, for: indexPath) as! FeedDetailsCell
        //cell.setupFeedData(datas: MockDataHere.favoriteList[indexPath.row])
        cell.addMark.tag = indexPath.row
        cell.addMark.addTarget(self, action: #selector(removeFavorite(sender: )), for: .touchUpInside)
        
        return cell
    }
    
    @objc func removeFavorite(sender: UIButton) {
//        if MockDataHere.favoriteList.contains(where: {$0.isFavorite == true}) {
//            UIView.animate(withDuration: 0.2) {
//                DispatchQueue.main.async {
//                    MockDataHere.favoriteList.remove(at: sender.tag)
//                    MockDataHere.myMockData[sender.tag].isFavorite = false
//                    self.favoriteTable.reloadData()
//                }
//            }
//            
//        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    #warning("количество надо уточнить")
        return 0
        //return MockDataHere.selectedContent.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesSelectionCell.reuseID, for: indexPath) as! FavoritesSelectionCell
        cell.setupContentForFavorites(fav: following[indexPath.row])
        return cell
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
