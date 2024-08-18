//
//  CustomAlert.swift
//  Sport News
//
//  Created by Abdusalom on 28/07/2024.
//


import UIKit


extension UIViewController {
    
    func presentWSNAlertOnMainThread(title: String, message: String, actionTitle: String) {
        DispatchQueue.main.async {
            let alertVC = WSNAlertVC(title: title, message: message, buttonTitle: actionTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true, completion: nil)
        }
    }
}




class WSNAlertVC: UIViewController {
    
    let containverView  = UIView()
    
    
    var titleLabel: UILabel = {
        
        let label                                       = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment                             = .center
        label.font                                      = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor                                 = .white
        label.adjustsFontSizeToFitWidth                 = true
        label.minimumScaleFactor                        = 0.3
        label.lineBreakMode                             = .byTruncatingTail
        return label
    }()
    
    var bodyLabel: UILabel = {
        let label                                       = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment                             = .center
        label.font                                      = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor                                 = .white
        return label
    }()
    
    var actionButton: UIButton = {
        let button                                       = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor                           = .red
        button.titleLabel?.font                          = UIFont.preferredFont(forTextStyle: .headline)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("OK", for: .normal)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    let padding: CGFloat = 20
    
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle     = title
        self.message        = message
        self.buttonTitle    = buttonTitle
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureBodyLabel()
        
    }
    
    
    func configureContainerView() {
        
        view.addSubview(containverView)
        containverView.translatesAutoresizingMaskIntoConstraints = false
        containverView.backgroundColor       = .black
        containverView.layer.cornerRadius    = 16
        containverView.layer.borderWidth     = 2
        containverView.layer.borderColor     = UIColor.white.cgColor
        
        NSLayoutConstraint.activate([
            containverView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containverView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containverView.widthAnchor.constraint(equalToConstant: 280),
            containverView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    func configureTitleLabel() {
        
        containverView.addSubview(titleLabel)
        
        titleLabel.text = alertTitle ?? "Something went wrong"
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: containverView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containverView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containverView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
            
        ])
    }
    
    func configureActionButton() {
        containverView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        
        NSLayoutConstraint.activate([
            
            actionButton.bottomAnchor.constraint(equalTo: containverView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containverView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containverView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    func configureBodyLabel() {
        containverView.addSubview(bodyLabel)
        bodyLabel.text          = message ?? "Unable to complete request"
        bodyLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            bodyLabel.leadingAnchor.constraint(equalTo: containverView.leadingAnchor, constant: padding),
            bodyLabel.trailingAnchor.constraint(equalTo: containverView.trailingAnchor, constant: -padding),
            bodyLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
            
        ])
    }
}
