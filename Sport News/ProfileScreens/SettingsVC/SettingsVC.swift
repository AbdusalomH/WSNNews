//
//  SettingsVC.swift
//  Sport News
//
//  Created by Abdusalom on 15/08/2024.
//

import UIKit

class SettingsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var settingsData = ["Edit Profile", "Write to support", "App rating", "Share app", "Delete favorites news", "Privacy Policy", "About", "Terms of Use"]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reuseID, for: indexPath) as! SettingsCell
        
        cell.setupData(names: settingsData[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = .black
        
        return cell
    }
    
    
    
    lazy var settingsTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .black
        table.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseID)
        return table
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettingView()

    }
    
    func setupSettingView() {
        view.addSubview(settingsTable)
        
        NSLayoutConstraint.activate([
            settingsTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            settingsTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


class SettingsCell: UITableViewCell {
    
    static let reuseID = "settingsCell"
    
    
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
        contentView.backgroundColor = .black
        setupView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        contentView.addSubview(icon)
        contentView.addSubview(settingsItem)
        
        NSLayoutConstraint.activate([
            
            icon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            icon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            icon.widthAnchor.constraint(equalToConstant: 24),
            icon.heightAnchor.constraint(equalToConstant: 24),
            
            settingsItem.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 12),
            settingsItem.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            settingsItem.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            settingsItem.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
    }
    
    
    func setupData(names: String) {
        settingsItem.text = names
    }
}
