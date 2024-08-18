//
//  MainVC.swift
//  Sport News
//
//  Created by Abdusalom on 30/06/2024.
//

import UIKit

protocol ProfileDelegate: AnyObject {
    func showLoginPage(state: LoginState)
    func showProvacy()
}


final class ProfileAuthVC: UIViewController {
    
    var authCoordinator: AuthCoordinator?
    
    var profileCoordinator: ProfileCoordinator?

    let logo = WSNLogo(frame: .zero)
    
    lazy var titleText2: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .white
        title.font = .systemFont(ofSize: 30, weight: .bold)
        title.text = "World Sport News"
        title.textAlignment = .left
        title.numberOfLines = 1
        title.minimumScaleFactor = 0.5
        return title
    }()
    
    lazy var profileTitle = WSNLabel(titleText: "Profile",
                                     labelTextColor: .white,
                                     fontSize: 30,
                                     weight: .bold,
                                     numberOfLines: 1,
                                     textAlighment: .left)
    
    lazy var userIcon: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(resource: .userlogin), for: .normal)
        button.setTitleColor(.systemBackground, for: .normal)
        return button
    }()
    
    lazy var subtitleText: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .gray
        title.font = .systemFont(ofSize: 24, weight: .regular)
        title.text = "Create or login an account to have full access to all functions"
        title.textAlignment = .center
        title.numberOfLines = 0
        title.minimumScaleFactor = 0.5
        return title
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)

        button.backgroundColor = #colorLiteral(red: 0.1803922057, green: 0.1803922057, blue: 0.1803922057, alpha: 1)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(makeLogin), for: .touchUpInside)
        return button
    }()

    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.backgroundColor = .red
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(makeSignUp), for: .touchUpInside)
        return button
    }()
    



    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        view.addSubview(userIcon)
        view.addSubview(logo)
        view.addSubview(profileTitle)
        view.addSubview(loginButton)
        view.addSubview(signUpButton)
        view.addSubview(subtitleText)
        
        NSLayoutConstraint.activate([
            
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            logo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logo.heightAnchor.constraint(equalToConstant: 30),
            logo.widthAnchor.constraint(equalToConstant: 60),
            
            profileTitle.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 12),
            profileTitle.centerYAnchor.constraint(equalTo: logo.centerYAnchor),
            profileTitle.heightAnchor.constraint(equalToConstant: 60),
            profileTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            userIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userIcon.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            userIcon.widthAnchor.constraint(equalToConstant: 150),
            userIcon.heightAnchor.constraint(equalToConstant: 150),
            
            subtitleText.topAnchor.constraint(equalTo: userIcon.bottomAnchor, constant: 12),
            subtitleText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            subtitleText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            
            signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -35),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.bottomAnchor.constraint(equalTo: signUpButton.topAnchor, constant: -12),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
        ])
        
        subtitleText.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    @objc func makeLogin() {
        self.profileCoordinator?.showSignIn()
        print("sigIn")
    }
    
    
    @objc func makeSignUp() {
        self.profileCoordinator?.showSignUp()
        print("signUp")
    }
}
