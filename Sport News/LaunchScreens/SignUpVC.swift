//
//  SignUpVC.swift
//  Sport News
//
//  Created by Abdusalom on 29/06/2024.
//

import UIKit

protocol LoginPageVCDelegate: AnyObject {
    func loginPageVCDidClose()
}

protocol SignUpDelegate: AnyObject {
    func privacy()
    func showLoginVC(state: LoginState)
    func showPrivacy()
}

final class SignUpVC: UIViewController  {
    
    let authNetwork = AuthsNetworkManager()
    
   
    var coordinator: SignUpDelegate?
    
    
    let logo = WSNLogo(frame: .zero)

    let loginTitle = WSNLabel(titleText: "World \nSport News", 
                              labelTextColor: .white,
                              fontSize: 50,
                              weight: .bold,
                              numberOfLines: 2,
                              textAlighment: .center)

    let loginSubtitle = WSNLabel(titleText: "All the latest news from the world of sports", 
                                 labelTextColor: .gray,
                                 fontSize: 22,
                                 weight: .regular,
                                 numberOfLines: 3,
                                 textAlighment: .center)
    
    let skipForNow = WSNButton(title: "Skip for now", 
                               titleColor: .gray)
    
    let signIn = WSNButton(title: "Log In", 
                           titleColor: .gray,
                           backgroundColor: .darkGray)
    
    let signUp = WSNButton(title: "Sign Up", 
                           titleColor: .white,
                           backgroundColor: .red)
    
    let titleDescription = WSNLabel(titleText: "Create an account to have full access to all functions", 
                                    labelTextColor: .gray,
                                    fontSize: 16,
                                    weight: .regular,
                                    numberOfLines: 0,
                                    textAlighment: .center)

    lazy var appleSignUp: UIButton = {
        
        var config = UIButton.Configuration.filled()
        config.title = "Sign in with Apple" // Установите текст
        config.baseForegroundColor = .lightGray
        config.baseBackgroundColor = .black
        config.imagePadding = 10 // Установите отступ между изображением и текстом
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        let originalImage = UIImage(resource: .appleXxl)
        let resizedImage = originalImage.resizeImage(image: originalImage, targetSize: CGSize(width: 24, height: 24))
        

        button.setImage(resizedImage, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        navigationItem.hidesBackButton = true
    }
    
    
    
    @objc func showSignUp() {
        self.coordinator?.showLoginVC(state: .signUp)
    }
    
    
    @objc func showLogin() {
        self.coordinator?.showLoginVC(state: .signIn)
    }
    
  
    
    private func setupView() {
        
        view.backgroundColor = .black
        
        view.addSubview(logo)
        view.addSubview(loginTitle)
        view.addSubview(loginSubtitle)
        view.addSubview(skipForNow)
        view.addSubview(signIn)
        view.addSubview(signUp)
        view.addSubview(appleSignUp)
        view.addSubview(titleDescription)
        
        NSLayoutConstraint.activate([
            
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            logo.heightAnchor.constraint(equalToConstant: 120),
            logo.widthAnchor.constraint(equalToConstant: 200),
            
            loginTitle.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 20),
            loginTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            loginTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            loginTitle.heightAnchor.constraint(equalToConstant: 120),
            
            loginSubtitle.topAnchor.constraint(equalTo: loginTitle.bottomAnchor, constant: 0),
            loginSubtitle.leadingAnchor.constraint(equalTo: logo.leadingAnchor, constant: 20),
            loginSubtitle.trailingAnchor.constraint(equalTo: logo.trailingAnchor, constant: -20),
            loginSubtitle.heightAnchor.constraint(equalToConstant: 90),
            
            skipForNow.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            skipForNow.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            skipForNow.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            skipForNow.heightAnchor.constraint(equalToConstant: 50),
            
            signIn.bottomAnchor.constraint(equalTo: skipForNow.topAnchor, constant: -12),
            signIn.heightAnchor.constraint(equalToConstant: 50),
            signIn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signIn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            signUp.bottomAnchor.constraint(equalTo: signIn.topAnchor, constant: -12),
            signUp.heightAnchor.constraint(equalToConstant: 50),
            signUp.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signUp.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        
            
            appleSignUp.bottomAnchor.constraint(equalTo: signUp.topAnchor, constant: -12),
            appleSignUp.heightAnchor.constraint(equalToConstant: 50),
            appleSignUp.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            appleSignUp.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            titleDescription.bottomAnchor.constraint(equalTo: appleSignUp.topAnchor, constant: -12),
            titleDescription.heightAnchor.constraint(equalToConstant: 70),
            titleDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

        ])
        
        skipForNow.addTarget(self, action: #selector(skipMe), for: .touchUpInside)
        signIn.addTarget(self, action: #selector(showLogin), for: .touchUpInside)
        signUp.addTarget(self, action: #selector(showSignUp), for: .touchUpInside)
    }
    
    
    @objc func skipMe() {
        
        Task {
            do {
                let anonymus = try await AuthsNetworkManager().anonymus()
                DispatchQueue.main.async {
                    KeychainManager.shared.saveToken(accessToken: anonymus.access_token)
                    KeychainManager.shared.saveRefreshToken(refreshToken: anonymus.refresh_token)
                    KeychainManager.shared.saveUserInfo(username: anonymus.profile.username, email: anonymus.profile.username)
                }
                
                self.coordinator?.showPrivacy()
            } catch {
                print("Something went wrond")
                presentWSNAlertOnMainThread(title: "Warnin", message: "Something went wrong", actionTitle: "OK")
            }
        }
    }

}

extension SignUpVC: LoginPageVCDelegate {
    func loginPageVCDidClose() {
        coordinator?.showPrivacy()
    }
}


