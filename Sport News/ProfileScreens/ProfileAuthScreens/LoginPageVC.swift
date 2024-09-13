//
//  LoginPageVC.swift
//  Sport News
//
//  Created by Abdusalom on 10/07/2024.
//

import UIKit


enum LoginState: Int {
    case signIn
    case signUp
}


class LoginPageVC: UIViewController, LogingViewModelDelegate {
    
    
    let viewModel = AuthViewModel()
    
    
    func didLoginSuccessfully() {
         self.loginLabel.isHidden = true
         self.dismiss(animated: true)
         self.delegate?.loginPageVCDidClose()
         self.profileCoordinator?.start()
         self.activityIndicator.stopAnimating()
         self.activityIndicator.removeFromSuperview()
    }
    
    
    func didFailLogin() {
        
        UIView.animate(withDuration: 3, delay: 0.3, usingSpringWithDamping: .infinity, initialSpringVelocity: .greatestFiniteMagnitude) {
            self.errorLabel.isHidden = false
        }
        self.activityIndicator.stopAnimating()
        self.activityIndicator.removeFromSuperview()
    }
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .red
        label.numberOfLines = 0
        label.text = "You email or password is incorrect!"
        label.isHidden = true
        return label
    }()
    
    
    weak var delegate: LoginPageVCDelegate?
    
    weak var authCoordinator: AuthCoordinator?
    
    var profileCoordinator: ProfileCoordinator?
    
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    
    let network = AuthsNetworkManager()
    
 
    var state: LoginState = .signIn {
        didSet {
            self.uisegment.selectedSegmentIndex = self.state.rawValue
        }
    }

    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(resource: .back), for: .normal)
        button.addTarget(self, action: #selector(backToProfile), for: .touchUpInside)
        return button
    }()
    
    
    lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    
    lazy var uisegment: UISegmentedControl = {
        let segment = UISegmentedControl()
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.selectedSegmentTintColor = #colorLiteral(red: 0.1083279178, green: 0.1083279178, blue: 0.1083279178, alpha: 1)
        segment.backgroundColor = .black
        segment.insertSegment(withTitle: "Sign In", at: 0, animated: false)
        segment.insertSegment(withTitle: "Sign Up", at: 1, animated: false)
        
        
        let selectedTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        let font = UIFont.systemFont(ofSize: 20)
        
        // Устанавливаем размер шрифта для всех состояний (normal и selected)
        let textAttributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
        ]
        segment.setTitleTextAttributes(textAttributes, for: .normal)
        segment.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        segment.selectedSegmentIndex = self.state.rawValue
        segment.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        return segment
    }()
    
    
    lazy var animateLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    //Sign In stuff
    lazy var textPlaceHolder: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .gray
        label.textAlignment = .left
        label.text = "E-mail"
        return label
    }()
    
    
    lazy var loginEmailTextField: UITextField = {
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
        textfield.textContentType = .emailAddress
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .no
        return textfield
    }()
    
    
    lazy var passwrdPlaceHolder: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .gray
        label.textAlignment = .left
        label.text = "Password"
        return label
    }()
    
    
    lazy var loginPasswordTextField: UITextField = {
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
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .no
        textfield.isSecureTextEntry = true
        return textfield
    }()
    
    
    lazy var signInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9595745206, green: 0.1748112142, blue: 0.06667741388, alpha: 1)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(sigInButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
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
        let resizedImage = resizeImage(image: originalImage, targetSize: CGSize(width: 24, height: 24))
        
        button.setImage(resizedImage, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        return button
    }()
    
    
    lazy var forgetPassword: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Forget password?", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.addTarget(self, action: #selector(forgotPsw), for: .touchUpInside)
        return button
    }()
    
    //Sign Up stuff
    
    lazy var signUpUsername: UITextField = {
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
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .no
        return textfield
    }()
    
    
    lazy var emailsignup: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.backgroundColor = .black
        textfield.layer.borderWidth = 2
        textfield.layer.cornerRadius = 5
        textfield.layer.borderColor = UIColor.darkGray.cgColor
        textfield.clipsToBounds = true
        textfield.textAlignment = .left
        textfield.textColor = .white
        textfield.textContentType = .password
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: textfield.frame.height)) // 12 - отступ слева
        textfield.leftView = paddingView
        textfield.leftViewMode = .always
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .no
        
        return textfield
    }()
    
    
    lazy var signUpEmailPlaceHolder: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .gray
        label.textAlignment = .left
        label.text = "E-mail"
        return label
    }()
    
    
    lazy var genderSegment: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Male", "Female", "Other"])
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.selectedSegmentTintColor = .red
        let selectedTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let font = UIFont.systemFont(ofSize: 20)
        
        // Устанавливаем размер шрифта для всех состояний (normal и selected)
        let textAttributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        segment.setTitleTextAttributes(textAttributes, for: .normal)
        segment.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        segment.selectedSegmentIndex = 0
        return segment
    }()
    
    
    lazy var birthDate: UIDatePicker = {
        let date = UIDatePicker()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.datePickerMode = .date
        date.backgroundColor = .white
        return date
    }()
    
    
    lazy var passwordSignUp: UITextField = {
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
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .no
        textfield.isSecureTextEntry = true
        textfield.textContentType = .oneTimeCode

        return textfield
    }()
    
    
    lazy var signUpPasswrdPlaceHolder: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .gray
        label.textAlignment = .left
        label.text = "Password"
        return label
    }()
    
    
    lazy var againPasswordSignUp: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.backgroundColor = .black
        textfield.layer.borderWidth = 2
        textfield.layer.cornerRadius = 5
        textfield.layer.borderColor = UIColor.darkGray.cgColor
        textfield.clipsToBounds = true
        textfield.textAlignment = .left
        textfield.textColor = .white
        textfield.textContentType = .oneTimeCode

        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: textfield.frame.height)) // 12 - отступ слева
        textfield.leftView = paddingView
        textfield.leftViewMode = .always
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .no
        textfield.isSecureTextEntry = true
        return textfield
    }()
    
    
    lazy var signUpAgainPasswrdPlaceHolder: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .gray
        label.textAlignment = .left
        label.text = "Password again"
        return label
    }()
    
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9595745206, green: 0.1748112142, blue: 0.06667741388, alpha: 1)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        return button
    }()
    
    
    lazy var signUpuserNamePlaceholder: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .gray
        label.textAlignment = .left
        label.text = "Username"
        return label
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.delegate = self
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
        navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.anibm()
    }
    
    
    @objc func sigInButtonTapped() {
        activityIndicatior()
        guard let email = loginEmailTextField.text, let passsword = loginPasswordTextField.text, !email.isEmpty, !passsword.isEmpty else {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            presentWSNAlertOnMainThread(title: "Warning", message: "Something went wrong", actionTitle: "OK")
            return
        }
        viewModel.login(email: email, password: passsword)
    }
    
    
    @objc func signUpTapped() {
        activityIndicatior()
        
        guard let username = signUpUsername.text, !username.isEmpty,
              let email = emailsignup.text, !email.isEmpty,
              let password = passwordSignUp.text, !password.isEmpty else {
            presentWSNAlertOnMainThread(title: "Warning", message: "Something went wrong", actionTitle: "OK")

            return
        }
        
        if passwordSignUp.text != againPasswordSignUp.text {
            presentWSNAlertOnMainThread(title: "Warning!", message: "Unable to complete request, your passwords doesn't match.", actionTitle: "OK")
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.removeFromSuperview()
            }
            return
        }

        viewModel.signUp(username: username, email: email, password: password)
    }
    
    
    func activityIndicatior() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        activityIndicator.color = .white
        activityIndicator.startAnimating()
    }
    
    
    func gotoProvicy() {
        self.authCoordinator?.privacy()
    }
    
    
    @objc func forgotPsw() {
        navigationController?.pushViewController(ForgotPswVC(), animated: true)
    }
    
    
    @objc func backToProfile() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true)
    }
    
    
    private func setupView() {
        view.backgroundColor = .black
        birthDate.setValue(UIColor.white, forKey: "textColor")
        
        
        view.addSubview(backButton)
        view.addSubview(loginLabel)
        view.addSubview(uisegment)
        view.addSubview(animateLine)
        
        // Add Sign In views
        view.addSubview(loginEmailTextField)
        view.addSubview(textPlaceHolder)
        view.addSubview(loginPasswordTextField)
        view.addSubview(passwrdPlaceHolder)
        view.addSubview(signInButton)
        view.addSubview(appleSignUp)
        view.addSubview(forgetPassword)
        
        // Add Sign Up views
        view.addSubview(signUpUsername)
        view.addSubview(emailsignup)
        view.addSubview(genderSegment)
        view.addSubview(birthDate)
        view.addSubview(passwordSignUp)
        view.addSubview(againPasswordSignUp)
        view.addSubview(signUpButton)
        view.addSubview(signUpEmailPlaceHolder)
        view.addSubview(signUpPasswrdPlaceHolder)
        view.addSubview(signUpAgainPasswrdPlaceHolder)
        view.addSubview(signUpuserNamePlaceholder)
        
        //add loging error label
        view.addSubview(errorLabel)
        
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            
            loginLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            loginLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 20),
            loginLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            uisegment.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 12),
            uisegment.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -5),
            uisegment.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 5),
            uisegment.heightAnchor.constraint(equalToConstant: 60),
            
            animateLine.topAnchor.constraint(equalTo: uisegment.bottomAnchor, constant: -2),
            animateLine.heightAnchor.constraint(equalToConstant: 2),
            animateLine.widthAnchor.constraint(equalTo: uisegment.widthAnchor, multiplier: 0.5),
            
            // Sign In constraints
            loginEmailTextField.topAnchor.constraint(equalTo: uisegment.bottomAnchor, constant: 30),
            loginEmailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginEmailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginEmailTextField.heightAnchor.constraint(equalToConstant: 70),
            
            textPlaceHolder.topAnchor.constraint(equalTo: loginEmailTextField.topAnchor, constant: 5),
            textPlaceHolder.leadingAnchor.constraint(equalTo: loginEmailTextField.leadingAnchor, constant: 12),
            
            loginPasswordTextField.topAnchor.constraint(equalTo: loginEmailTextField.bottomAnchor, constant: 30),
            loginPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginPasswordTextField.heightAnchor.constraint(equalToConstant: 70),
            
            passwrdPlaceHolder.topAnchor.constraint(equalTo: loginPasswordTextField.topAnchor, constant: 5),
            passwrdPlaceHolder.leadingAnchor.constraint(equalTo: loginPasswordTextField.leadingAnchor, constant: 12),
            
            signInButton.topAnchor.constraint(equalTo: loginPasswordTextField.bottomAnchor, constant: 30),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signInButton.heightAnchor.constraint(equalToConstant: 60),
            
            appleSignUp.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20),
            appleSignUp.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            appleSignUp.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            appleSignUp.heightAnchor.constraint(equalToConstant: 60),
            
            forgetPassword.topAnchor.constraint(equalTo: appleSignUp.bottomAnchor, constant: 20),
            forgetPassword.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Sign Up constraints
            
            signUpUsername.topAnchor.constraint(equalTo: uisegment.bottomAnchor, constant: 30),
            signUpUsername.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signUpUsername.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signUpUsername.heightAnchor.constraint(equalToConstant: 60),
            
            signUpuserNamePlaceholder.topAnchor.constraint(equalTo: signUpUsername.topAnchor, constant: 5),
            signUpuserNamePlaceholder.leadingAnchor.constraint(equalTo: signUpUsername.leadingAnchor, constant: 12),
            
            emailsignup.topAnchor.constraint(equalTo: signUpUsername.bottomAnchor, constant: 20),
            emailsignup.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailsignup.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailsignup.heightAnchor.constraint(equalToConstant: 60),
            
            signUpEmailPlaceHolder.topAnchor.constraint(equalTo: emailsignup.topAnchor, constant: 5),
            signUpEmailPlaceHolder.leadingAnchor.constraint(equalTo: emailsignup.leadingAnchor, constant: 12),
            
            genderSegment.topAnchor.constraint(equalTo: emailsignup.bottomAnchor, constant: 20),
            genderSegment.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            genderSegment.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            genderSegment.heightAnchor.constraint(equalToConstant: 60),
            
            birthDate.topAnchor.constraint(equalTo: genderSegment.bottomAnchor, constant: 20),
            birthDate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            passwordSignUp.topAnchor.constraint(equalTo: birthDate.bottomAnchor, constant: 20),
            passwordSignUp.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordSignUp.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordSignUp.heightAnchor.constraint(equalToConstant: 60),
            
            signUpPasswrdPlaceHolder.topAnchor.constraint(equalTo: passwordSignUp.topAnchor, constant: 5),
            signUpPasswrdPlaceHolder.leadingAnchor.constraint(equalTo: passwordSignUp.leadingAnchor, constant: 12),
            
            againPasswordSignUp.topAnchor.constraint(equalTo: passwordSignUp.bottomAnchor, constant: 20),
            againPasswordSignUp.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            againPasswordSignUp.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            againPasswordSignUp.heightAnchor.constraint(equalToConstant: 60),
            
            signUpAgainPasswrdPlaceHolder.topAnchor.constraint(equalTo: againPasswordSignUp.topAnchor, constant: 5),
            signUpAgainPasswrdPlaceHolder.leadingAnchor.constraint(equalTo: againPasswordSignUp.leadingAnchor, constant: 12),
            
            signUpButton.topAnchor.constraint(equalTo: againPasswordSignUp.bottomAnchor, constant: 30),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signUpButton.heightAnchor.constraint(equalToConstant: 60),
            
            errorLabel.topAnchor.constraint(equalTo: uisegment.bottomAnchor, constant: 8),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            errorLabel.bottomAnchor.constraint(equalTo: loginEmailTextField.topAnchor, constant: -8),
            errorLabel.trailingAnchor.constraint(equalTo: uisegment.trailingAnchor)
        ])
    }
    
    
    private func updateView() {
        
        let isSignIn = uisegment.selectedSegmentIndex == 0
        
        loginLabel.text = isSignIn ? "Sign In" : "Sign Up"
            
        loginEmailTextField.isHidden = !isSignIn
        textPlaceHolder.isHidden = !isSignIn
        loginPasswordTextField.isHidden = !isSignIn
        passwrdPlaceHolder.isHidden = !isSignIn
        signInButton.isHidden = !isSignIn
        appleSignUp.isHidden = !isSignIn
        forgetPassword.isHidden = !isSignIn
        
        signUpUsername.isHidden = isSignIn
        emailsignup.isHidden = isSignIn
        genderSegment.isHidden = isSignIn
        birthDate.isHidden = isSignIn
        passwordSignUp.isHidden = isSignIn
        againPasswordSignUp.isHidden = isSignIn
        signUpButton.isHidden = isSignIn
        signUpEmailPlaceHolder.isHidden = isSignIn
        signUpPasswrdPlaceHolder.isHidden = isSignIn
        signUpuserNamePlaceholder.isHidden = isSignIn
        signUpAgainPasswrdPlaceHolder.isHidden = isSignIn
        UIView.animate(withDuration: 0.3) {
            self.anibm()
        }
    }

    func anibm(){
        let secondItem = self.uisegment.frame.width / 2
        self.animateLine.frame.origin.x = self.uisegment.selectedSegmentIndex == 0 ? 0 : secondItem
    }
    
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        updateView()
        anibm()
    }

    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Определяем коэффициент масштабирования, чтобы сохранить пропорции
        let newSize = CGSize(width: size.width * min(widthRatio, heightRatio),
                             height: size.height * min(widthRatio, heightRatio))
        
        // Создаем новый CGRect с новым размером
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Рисуем изображение в новом размере
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
