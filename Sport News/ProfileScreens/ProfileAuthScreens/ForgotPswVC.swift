//
//  ForgotPswVC.swift
//  Sport News
//
//  Created by Abdusalom on 13/07/2024.
//

import UIKit



class ForgotPswVC: UIViewController {

    lazy var restoreTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.text = "Restore password"
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    lazy var backImage: UIButton = {
        let backButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(UIImage(named: "Back"), for: .normal)
        backButton.layer.cornerRadius = 20
        backButton.contentMode = .scaleAspectFill
        backButton.tintColor = .black
        backButton.layer.shadowColor = UIColor.darkGray.cgColor
        backButton.layer.shadowRadius = 10
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return backButton
    }()
    
    lazy var emailTextField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.backgroundColor = .black
        textfield.layer.borderWidth = 2
        textfield.layer.cornerRadius = 5
        textfield.layer.borderColor = UIColor.darkGray.cgColor
        textfield.clipsToBounds = true
        textfield.textAlignment = .left
        textfield.textColor = .white
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: textfield.frame.height)) // 12 - отступ слева
        textfield.leftView = paddingView
        textfield.leftViewMode = .always
        return textfield
    }()
    
    lazy var newpasserdTextField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.backgroundColor = .black
        textfield.layer.borderWidth = 2
        textfield.layer.cornerRadius = 5
        textfield.layer.borderColor = UIColor.darkGray.cgColor
        textfield.clipsToBounds = true
        textfield.textAlignment = .left
        textfield.textColor = .white
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: textfield.frame.height)) // 12 - отступ слева
        textfield.leftView = paddingView
        textfield.leftViewMode = .always
        return textfield
    }()
    
    lazy var confirmationCodeTextField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.backgroundColor = .black
        textfield.layer.borderWidth = 2
        textfield.layer.cornerRadius = 5
        textfield.layer.borderColor = UIColor.darkGray.cgColor
        textfield.clipsToBounds = true
        textfield.textAlignment = .left
        textfield.textColor = .white
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: textfield.frame.height)) // 12 - отступ слева
        textfield.leftView = paddingView
        textfield.leftViewMode = .always
        return textfield
    }()
    
    lazy var emailPlaceholder: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .gray
        label.textAlignment = .left
        label.text = "E-mail"
        return label
    }()
    
    lazy var newpasswordPlaceholder: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .gray
        label.textAlignment = .left
        label.text = "New Password"
        return label
    }()
    
    lazy var confirmationPlaceholder: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .gray
        label.textAlignment = .left
        label.text = "Confirmation code"
        return label
    }()
    
    lazy var sendCodeBTN: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Send Code", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.darkGray, for: .highlighted)
        button.backgroundColor = .red
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    
    
    @objc func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        view.addSubview(backImage)
        view.addSubview(restoreTitle)
        
        view.addSubview(emailTextField)
        view.addSubview(newpasserdTextField)
        view.addSubview(confirmationCodeTextField)
        view.addSubview(emailPlaceholder)
        view.addSubview(newpasswordPlaceholder)
        view.addSubview(confirmationPlaceholder)
        view.addSubview(sendCodeBTN)
        
        NSLayoutConstraint.activate([
            
            backImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            backImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            backImage.heightAnchor.constraint(equalToConstant: 38),
            backImage.widthAnchor.constraint(equalToConstant: 38),
            
            restoreTitle.centerYAnchor.constraint(equalTo: backImage.centerYAnchor),
            restoreTitle.leadingAnchor.constraint(equalTo: backImage.trailingAnchor, constant: 12),
            restoreTitle.heightAnchor.constraint(equalToConstant: 40),
            
            emailTextField.topAnchor.constraint(equalTo: restoreTitle.bottomAnchor, constant: 30),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 70),
            
            emailPlaceholder.topAnchor.constraint(equalTo: emailTextField.topAnchor, constant: 5),
            emailPlaceholder.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor, constant: 12),
            
            newpasserdTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30),
            newpasserdTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            newpasserdTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            newpasserdTextField.heightAnchor.constraint(equalToConstant: 70),
            
            newpasswordPlaceholder.topAnchor.constraint(equalTo: newpasserdTextField.topAnchor, constant: 5),
            newpasswordPlaceholder.leadingAnchor.constraint(equalTo: newpasserdTextField.leadingAnchor, constant: 12),
            
            confirmationCodeTextField.topAnchor.constraint(equalTo: newpasserdTextField.bottomAnchor, constant: 30),
            confirmationCodeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            confirmationCodeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            confirmationCodeTextField.heightAnchor.constraint(equalToConstant: 70),
            
            confirmationPlaceholder.topAnchor.constraint(equalTo: confirmationCodeTextField.topAnchor, constant: 5),
            confirmationPlaceholder.leadingAnchor.constraint(equalTo: confirmationCodeTextField.leadingAnchor, constant: 12),
            
            sendCodeBTN.topAnchor.constraint(equalTo: confirmationCodeTextField.bottomAnchor, constant: 30),
            sendCodeBTN.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            sendCodeBTN.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            sendCodeBTN.heightAnchor.constraint(equalToConstant: 70),
        ])
    }
}
