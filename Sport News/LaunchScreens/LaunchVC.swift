//
//  ViewController.swift
//  Sport News
//
//  Created by Abdusalom on 29/06/2024.
//

import UIKit
import FirebaseAuth

final class LaunchVC: UIViewController {
    
    weak var authCoordinator: AuthCoordinator?
    
    var username: String?
    var email: String?

    
    let logo = WSNLogo(frame: .zero)
    
    let launchTitle = WSNLabel(titleText: "World \nSport News",
                                labelTextColor: .white,
                                fontSize: 50,
                                weight: .bold,
                               numberOfLines: 2, 
                               textAlighment: .center)
    
    let subtitleText = WSNLabel(titleText: "All the latest news from the world of sports",
                                labelTextColor: .gray,
                                fontSize: 22,
                                weight: .bold,
                                numberOfLines: 3, 
                                textAlighment: .center)
    
    let progressViewText = WSNLabel(titleText: "Please wait, loading...", 
                                    labelTextColor: .darkGray,
                                    fontSize: 16,
                                    weight: .regular,
                                    numberOfLines: 1,
                                    textAlighment: .center)
    
    lazy var progressView: UIProgressView = {
        let progress = UIProgressView()
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.trackTintColor = .black
        progress.progressTintColor = .red
        progress.setProgress(0, animated: true)
        progress.layer.cornerRadius = 5
        progress.clipsToBounds = true
        return progress
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupView()
        authenticateUser()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateSliderToMaximumValue(progress: progressView)
    }
    
    
    private func authenticateUser() {
        if let savedUID = UserDefaults.standard.string(forKey: "uid") {
            // Проверка, существует ли текущий аутентифицированный пользователь с сохраненным UID
            Auth.auth().signInAnonymously { (authResult, error) in
                if let error = error {
                    print("Error signing in anonymously: \(error.localizedDescription)")
                    return
                }
                if let user = authResult?.user, user.uid == savedUID {
                    print("User is already signed in with UID: \(user.uid)")
                    // Пользователь уже аутентифицирован
                } else {
                    self.signInAnonymouslyAndSaveUID()
                }
            }
        } else {
            // Нет сохраненного UID, создаем нового анонимного пользователя
            signInAnonymouslyAndSaveUID()
        }
    }
    
    private func signInAnonymouslyAndSaveUID() {
        Auth.auth().signInAnonymously { (authResult, error) in
            if let error = error {
                print("Error signing in anonymously: \(error.localizedDescription)")
                return
            }
            if let user = authResult?.user {
                print("Signed in anonymously with UID: \(user.uid)")
                UserDefaults.standard.set(user.uid, forKey: "uid")
                // Новый анонимный пользователь создан и UID сохранен
            }
        }
    }
  
    private func animateSliderToMaximumValue( progress: UIProgressView) {
        UIView.animate(withDuration: 3.0, delay: 1, options: .curveEaseInOut, animations: {
            progress.setProgress(1, animated: true)
        }, completion: { finished in
            if finished {
                
                if let username = KeychainManager.shared.getUserInfo().username {
                    print(username)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.authCoordinator?.showMainTabBar()
                    }
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.authCoordinator?.showSignUp()
                        
                     }
                }
            }
        })
    }
     
    private func setupView() {
        view.addSubview(logo)
        view.addSubview(launchTitle)
        view.addSubview(subtitleText)
        view.addSubview(progressViewText)
        view.addSubview(progressView)
        
        NSLayoutConstraint.activate([
            
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -130),
            logo.heightAnchor.constraint(equalToConstant: 160),
            logo.widthAnchor.constraint(equalToConstant: 290),
            
            launchTitle.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 20),
            launchTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            launchTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            launchTitle.heightAnchor.constraint(equalToConstant: 120),
            
            subtitleText.topAnchor.constraint(equalTo: launchTitle.bottomAnchor, constant: 0),
            subtitleText.leadingAnchor.constraint(equalTo: logo.leadingAnchor),
            subtitleText.trailingAnchor.constraint(equalTo: logo.trailingAnchor),
            subtitleText.heightAnchor.constraint(equalToConstant: 90),
            
            progressView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            progressView.heightAnchor.constraint(equalToConstant: 5),
 
            
            progressViewText.bottomAnchor.constraint(equalTo: progressView.topAnchor, constant: -8),
            progressViewText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            progressViewText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            progressViewText.heightAnchor.constraint(equalToConstant: 20),
            
            
            
        ])
    }
}

