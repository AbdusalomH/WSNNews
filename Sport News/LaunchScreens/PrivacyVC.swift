//
//  PrivacyVC.swift
//  Sport News
//
//  Created by Abdusalom on 29/06/2024.
//

import UIKit


protocol PrivacyDelegate {
    func showFavoriteList()
}

final class PrivacyVC: UIViewController {
    
    var authCoordinator: AuthCoordinator?
    
    let logo = WSNLogo(frame: .zero)
    
    let mainTitle = WSNLabel(titleText: "World \nSport News",
                             labelTextColor: .white,
                             fontSize: 50,
                             weight: .black,
                             numberOfLines: 2,
                             textAlighment: .center)
    
    let subtitleText = WSNLabel(titleText: "All the latest news from the world of sports",
                                labelTextColor: .gray,
                                fontSize: 22,
                                weight: .regular,
                                numberOfLines: 3,
                                textAlighment: .center)

    
    lazy var privacyText: UITextView = {
        let label = UITextView()
        let fullText = "The articles listed this app are taken from online news sources. They do not necessarity refrect the opinions of this app or its administration. By using the app you agree our Privacy Policy and Terms of Service"
        let firstTargetText = "Privacy Policy"
        let secondTargetText = "Terms of Service"
        
        label.isSelectable = true
        label.isEditable = false
        label.isScrollEnabled = false
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textAlignment = .center
        label.delaysContentTouches = false

        
        let attributedString = NSMutableAttributedString(string: fullText)
        
        attributedString.addAttribute(.link, value: "privacy://privacy", range: (attributedString.string as NSString).range(of: firstTargetText))
        attributedString.addAttribute(.link, value: "terms://terms", range: (attributedString.string as NSString).range(of: secondTargetText))
        
        label.linkTextAttributes = [.foregroundColor: UIColor.white]
        label.attributedText = attributedString
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
  
        return label
    }()
    
    
    @objc func tappedOnLabel(_ gesture: UITapGestureRecognizer) {

    }

    
    let proceed = WSNButton(title: "Proceed", 
                            titleColor: .white,
                            backgroundColor: .red)


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationItem.hidesBackButton = true
        setup()
        privacyText.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    private func setup() {
                
        view.addSubview(logo)
        view.addSubview(mainTitle)
        view.addSubview(subtitleText)
        view.addSubview(privacyText)
        view.addSubview(proceed)
        
        NSLayoutConstraint.activate([
            
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            logo.heightAnchor.constraint(equalToConstant: 160),
            logo.widthAnchor.constraint(equalToConstant: 290),
            
            mainTitle.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 20),
            mainTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            mainTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            mainTitle.heightAnchor.constraint(equalToConstant: 120),
            
            subtitleText.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 0),
            subtitleText.leadingAnchor.constraint(equalTo: logo.leadingAnchor, constant: 20),
            subtitleText.trailingAnchor.constraint(equalTo: logo.trailingAnchor, constant: -20),
            subtitleText.heightAnchor.constraint(equalToConstant: 90),
            
            
            proceed.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            proceed.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            proceed.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            proceed.heightAnchor.constraint(equalToConstant: 50),
            
            
            privacyText.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            privacyText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            privacyText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            privacyText.topAnchor.constraint(equalTo: subtitleText.bottomAnchor, constant: 20),
        ])
        
        proceed.addTarget(self, action: #selector(navigateToFav), for: .touchUpInside)
    }
    
    @objc func navigateToFav() {
        authCoordinator?.showFavoriteList()
    }
}

extension PrivacyVC: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.scheme == "terms" {
            authCoordinator?.showTermOfUse()
        } else if URL.scheme == "privacy" {
            authCoordinator?.showPrivacyDetails()
        }
        
        
        return true
    }
    
    
    
}
