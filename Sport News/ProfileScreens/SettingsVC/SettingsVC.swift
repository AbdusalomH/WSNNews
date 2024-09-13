//
//  SettingsVC.swift
//  Sport News
//
//  Created by Abdusalom on 15/08/2024.
//

import UIKit

class SettingsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var settingsData = ["Edit Profile", "Write to support", "App rating", "Share app", "Delete favorites news", "Privacy Policy", "About", "Terms of Use"]

    
    lazy var settingsTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .black
        table.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseID)
        table.isScrollEnabled = false
        return table
    }()
    
    lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Logout", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.clipsToBounds = true
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettingView()
    }
    
    
    func setupSettingView() {
        view.backgroundColor = .black
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.tintColor = .white
        view.addSubview(settingsTable)
        view.addSubview(logoutButton)
        
        NSLayoutConstraint.activate([
            settingsTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            settingsTable.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            logoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -110),
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            logoutButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reuseID, for: indexPath) as! SettingsCell
        cell.setupData(names: settingsData[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedSetting = settingsData[indexPath.row]
        
        switch selectedSetting {
            
        case "Edit Profile":
            print("Edit Profile")
            
        case "Write to support":
            print("Write to support")
            
        default:
            break
        }
    }
    
}


class SettingsCell: UITableViewCell {
    
    static let reuseID = "settingsCell"
    
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.1098039076, green: 0.1098039076, blue: 0.1098039076, alpha: 1)
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    
    
    lazy var arrowIcon: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFill
        icon.image = UIImage(systemName: "chevron.right")
        icon.tintColor = #colorLiteral(red: 0.2901960909, green: 0.2901960909, blue: 0.2901960909, alpha: 1)
        return icon
    }()
    
    
    lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFill
        icon.image = UIImage(resource: .settings99)
        return icon
    }()
    
    
    lazy var settingsItem: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        contentView.backgroundColor = .black
        selectionStyle = .none
        setupView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        
        contentView.addSubview(containerView)
        containerView.addSubview(icon)
        containerView.addSubview(settingsItem)
        containerView.addSubview(arrowIcon)
        
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            containerView.heightAnchor.constraint(equalToConstant: 48),
            
            icon.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            icon.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            icon.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            icon.widthAnchor.constraint(equalToConstant: 24),
            icon.heightAnchor.constraint(equalToConstant: 24),
            
            settingsItem.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 12),
            settingsItem.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            settingsItem.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            settingsItem.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            
            arrowIcon.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            arrowIcon.heightAnchor.constraint(equalToConstant: 16),
            arrowIcon.widthAnchor.constraint(equalToConstant: 16),
            arrowIcon.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
        ])
    }
    
    
    func setupData(names: String) {
        settingsItem.text = names
    }
}
