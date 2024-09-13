//
//  PrivacyPolicyVC.swift
//  Sport News
//
//  Created by Abdusalom on 15/08/2024.
//

import UIKit

class PrivacyPolicyVC: UIViewController {
    
    
    var authcoordinator: AuthCoordinator?
    
   
    lazy var privacyText: WSNWithEdgesLabel = {
        
        let text = WSNWithEdgesLabel(withInsets: 20, 20, 20, 20)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 0
        text.textAlignment = .left
        text.backgroundColor = .clear
        text.textColor = .lightGray
        
        let fullText = APPTexts.shared.privaText
        
        let attributes = NSMutableAttributedString(string: fullText)
        
        attributes.addAttribute(.font, value: UIFont.systemFont(ofSize: 22, weight: .semibold), range: NSRange(location: 0, length: 65))
        attributes.addAttribute(.font, value: UIFont.systemFont(ofSize: 22, weight: .semibold), range: NSRange(location: 499, length: 77))
        attributes.addAttribute(.font, value: UIFont.systemFont(ofSize: 22, weight: .semibold), range: NSRange(location: 1301, length: 79))
        
        attributes.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: 65))
        attributes.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 499, length: 77))
        attributes.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 1301, length: 79))

        text.attributedText = attributes

        return text
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .white
        
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(privacyText)
        
        //view.addSubview(privacyText)
        
        NSLayoutConstraint.activate([
            
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            privacyText.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            privacyText.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            privacyText.topAnchor.constraint(equalTo: scrollView.topAnchor),
            privacyText.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            privacyText.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            
//            privacyText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            privacyText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
//            privacyText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
//            privacyText.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .white
        
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

    }
}


