//
//  CommentVC.swift
//  Sport News
//
//  Created by Abdusalom on 07/07/2024.
//

//CommentVC - таблица комментов

import UIKit

struct CommentsModel {
    
    let username: String
    let commentTime: String
    let commentText: String
    let likeCount: Int
    
}

protocol GoBackProtocol {
    func didTapToBackButton()
}

fileprivate var commentsMockData = [
    
    CommentsModel(username: "John Walker", commentTime: "15 minutes", commentText: "He also said thank you to the volunteers comms assisting in the world record registration. He also said thank you to the volunteers comms assisting in the world record registration. He also said thank you to the volunteers comms assisting in the world record registration.", likeCount: 23),
    
    CommentsModel(username: "Steve Champ", commentTime: "2 hours", commentText: "He also said thank you to the volunteers comms assisting in the world record registration. He also said thank you to the volunteers comms assisting in the world record registration.", likeCount: 21),
    
    CommentsModel(username: "Mike", commentTime: "1 hour", commentText: "He also said thank you to the volunteers comms assisting in the world record registration. He also said thank you to the volunteers comms assisting in the world record registration.He also said thank you to the volunteers comms assisting in the world record registration.", likeCount: 13),
    
    CommentsModel(username: "Lilu", commentTime: "1.5 hour", commentText: "He also said thank you to the volunteers comms assisting in the world record registration. He also said thank you to the volunteers comms assisting in the world record registration. He also said thank you to the volunteers comms assisting in the world record registration. He also said thank you to the volunteers comms assisting in the world record registration. He also said thank you to the volunteers comms assisting in the world record registration.", likeCount: 10),
    
    CommentsModel(username: "Jerry", commentTime: "2 hours", commentText: "He also said thank you to the volunteers comms assisting in the world record registration. He also said thank you to the volunteers comms assisting in the world record registration.", likeCount: 42),
    
    CommentsModel(username: "Oleg", commentTime: "2 hours", commentText: "He also said thank you to the volunteers comms assisting in the world record registration. He also said thank you to the volunteers comms assisting in the world record registration. He also said thank you to the volunteers comms assisting in the world record registration.", likeCount: 3),
]


class CommentVC: UIViewController {
    
    let newsID: Int
    
    init(newsID: Int) {
        self.newsID = newsID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var delegateGoBack: GoBackProtocol?
    
    let netRoute = NewsNetworkManager()
    
    lazy var commentTitleContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.1098039076, green: 0.1098039076, blue: 0.1098039076, alpha: 1)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        return view
    }()
    
    lazy var commentTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "All Comments"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    lazy var backImageButton: UIButton = {
        let backButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(UIImage(resource: .back), for: .normal)
        backButton.layer.cornerRadius = 20
        backButton.contentMode = .scaleAspectFill
        backButton.tintColor = .white
        backButton.layer.shadowColor = UIColor.darkGray.cgColor
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return backButton
    }()
    
    let commentTitleLabelCount = WSNLabel(titleText: "258", labelTextColor: .gray, fontSize: 16, weight: .semibold, numberOfLines: 1, textAlighment: .right)
    
    lazy var commentTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(CommentCell.self, forCellReuseIdentifier: CommentCell.reuseID)
        table.backgroundColor = .black
        return table
    }()
    
    lazy var commentContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.1215686426, green: 0.1215686426, blue: 0.1215686426, alpha: 1)
        return view
    }()
    
    lazy var commentOwner: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(resource: .ava)
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var commentTexfield: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.placeholder = "Enter a comment"
        text.backgroundColor = #colorLiteral(red: 0.1803922057, green: 0.1803922057, blue: 0.1803922057, alpha: 1)
        text.layer.cornerRadius = 10
        text.textColor = .white
        text.clipsToBounds = true
        
        // Изменение цвета placeholder
        text.attributedPlaceholder = NSAttributedString(
            string: "Enter a comment",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        
        // Добавление отступов
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: text.frame.height))
        text.leftView = paddingView
        text.leftViewMode = .always
        
        let width = view.bounds.width - 120
        
        text.widthAnchor.constraint(equalToConstant: width).isActive = true
        text.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        return text
    }()
    
    lazy var sendButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(resource: .send), for: .normal)
        //button.isHidden = true
        button.addTarget(self, action: #selector(sendComment), for: .touchUpInside)
        return button
    }()
    
    lazy var inputStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [commentTexfield, sendButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupView()
        showHideKeyboard()
        
        getComment(id: newsID)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let index = IndexPath(row: commentsMockData.count - 1, section: 0)
        DispatchQueue.main.async {
            self.commentTable.scrollToRow(at: index, at: .bottom, animated: true)
        }
    }
    
    func getComment(id: Int) {
        netRoute.getNewsComment(id: id) { newsComment, error in
            guard let receviedComment = newsComment else { return }
            print(receviedComment)
            
            guard let receviedError = error?.localizedDescription else {
                print("receviedError")
                return
            }
            print(receviedError)
        }
    }
    
    
    func setupView() {
        
        view.addSubview(commentTitleContainer)
        
        commentTitleContainer.addSubview(backImageButton)
        commentTitleContainer.addSubview(commentTitleLabel)
        commentTitleContainer.addSubview(commentTitleLabelCount)
        
        view.addSubview(commentContainer)
        view.addSubview(commentTable)
        
        
        commentContainer.addSubview(commentOwner)
        commentContainer.addSubview(commentTexfield)
        commentContainer.addSubview(sendButton)
 
        
        NSLayoutConstraint.activate([
            
            commentTitleContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: -2),
            commentTitleContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -2),
            commentTitleContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 2),
            commentTitleContainer.heightAnchor.constraint(equalToConstant: 110),
            
            backImageButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            backImageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            backImageButton.heightAnchor.constraint(equalToConstant: 38),
            backImageButton.widthAnchor.constraint(equalToConstant: 38),
            
            commentTitleLabel.centerYAnchor.constraint(equalTo: backImageButton.centerYAnchor),
            commentTitleLabel.leadingAnchor.constraint(equalTo: backImageButton.trailingAnchor, constant: 12),
            commentTitleLabel.heightAnchor.constraint(equalToConstant: 30),
            commentTitleLabel.widthAnchor.constraint(equalToConstant: 150),
            
            commentTitleLabelCount.centerYAnchor.constraint(equalTo: commentTitleLabel.centerYAnchor),
            commentTitleLabelCount.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            commentTitleLabelCount.heightAnchor.constraint(equalToConstant: 20),
            commentTitleLabelCount.widthAnchor.constraint(equalToConstant: 60),
            
            commentTable.topAnchor.constraint(equalTo: view.topAnchor, constant: 122),
            commentTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            commentTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            commentTable.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -180),
            
            commentContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            commentContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            commentContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            commentContainer.heightAnchor.constraint(equalToConstant: 70),
            
            commentOwner.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            commentOwner.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            commentOwner.heightAnchor.constraint(equalToConstant: 30),
            commentOwner.widthAnchor.constraint(equalToConstant: 30),
            
            commentTexfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            commentTexfield.heightAnchor.constraint(equalToConstant: 30),
            commentTexfield.centerYAnchor.constraint(equalTo: commentContainer.centerYAnchor),
            commentTexfield.trailingAnchor.constraint(equalTo: commentContainer.trailingAnchor, constant: -60),
            
            sendButton.centerYAnchor.constraint(equalTo: commentTexfield.centerYAnchor),
            sendButton.trailingAnchor.constraint(equalTo: commentContainer.trailingAnchor, constant: -8),
            sendButton.heightAnchor.constraint(equalToConstant: 30),
            sendButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func showHideKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func sendComment() {
        if commentTexfield.text?.isEmpty == false {
            
            commentsMockData.append(CommentsModel(username: "Will Smith",
                                                  commentTime: "22 minutes",
                                                  commentText: commentTexfield.text ?? "",
                                                  likeCount: 99))
            
            commentTable.reloadData()
            DispatchQueue.main.async {
                let indexPath = IndexPath(row: commentsMockData.count - 1, section: 0)

                self.commentTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
                self.commentTexfield.text = ""
            }
            view.endEditing(true)
        }
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height - 20
            UIView.animate(withDuration: 1) {
                let index = IndexPath(row: commentsMockData.count - 1, section: 0)
                self.commentTable.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight + self.view.safeAreaInsets.bottom)
                self.commentContainer.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight + self.view.safeAreaInsets.bottom)
                self.commentTable.scrollToRow(at: index, at: .bottom, animated: true)
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.1) {
            self.commentTable.transform = .identity
            self.commentContainer.transform = .identity
        }
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

}


extension CommentVC: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsMockData.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.reuseID, for: indexPath) as! CommentCell
        cell.setupViewData(commentdata: commentsMockData[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}
