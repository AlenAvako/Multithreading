//
//  FeedViewController.swift
//  Navigation
//
//  Created by Ален Авако on 10.09.2021.
//

import SnapKit

class FeedViewController: UIViewController {
    
    var checker: RandomWord
    
    var customWord: String = ""
    
    private lazy var customButton: CustomButton = {
        let button = CustomButton(color: "colorSuper", title: "Check", titleColor: .white, cornerRadius: 10)
        button.toAutoLayout()
        button.tapButton = { [self] in
            let checkWord = self.customWord
            self.checker.check(word: checkWord) { [ weak self ] checking in
                switch checking {
                case .empty:
                    self?.statusLabel.text = "No Text"
                    self?.statusLabel.textColor = .purple
                case .correct:
                    self?.statusLabel.text = self?.customWord
                    self?.statusLabel.textColor = .green
                case .incorrect:
                    self?.statusLabel.text = self?.customWord
                    self?.statusLabel.textColor = .red
                }
            }
        }
        return button
    }()
    
    private lazy var customTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Check here", indent: 10, textColor: .black, backgroundColor: .white)
        textField.toAutoLayout()
        textField.addTarget(self, action: #selector(saveCustomWord), for: .editingChanged)
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "Статус"
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
    }()

    let post = Post(title: "Новости")
    
    let stackView = UIStackView()
    private let buttonToPostView = CustomButton(color: "colorSuper", title: "Hello", titleColor: .white, cornerRadius: 10)
    private let newButtonToPostView = CustomButton(color: "colorSuper", title: "World", titleColor: .white, cornerRadius: 10)
    
    init(checker: RandomWord) {
        self.checker = checker
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Feed"
        self.view.backgroundColor = .white
        
        configureStackView()
    }
    
//    MARK: configure
    func configureStackView() {
        view.addSubviews(stackView, customTextField, customButton, statusLabel)

        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        
        setStackViewConstraint()
        addButtonToStackView()
    }
    
    func configurePostViewButton() {
        buttonToPostView.tapButton = { [ weak self ] in
            let postVC = PostViewController()
            postVC.postTitle = self?.post.title
            self?.navigationController?.pushViewController(postVC, animated: true)
        }
        
        newButtonToPostView.tapButton = { [ weak self ] in
            let postVC = PostViewController()
            postVC.postTitle = self?.post.title
            self?.navigationController?.pushViewController(postVC, animated: true)
        }
        
        setButtonsConstraints()
    }
    
    func addButtonToStackView() {
        stackView.addArrangedSubview(buttonToPostView)
        stackView.addArrangedSubview(newButtonToPostView)
        
        configurePostViewButton()
    }
    
//    MARK: constraints
    func setStackViewConstraint() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        customTextField.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(16)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.height.equalTo(50)
        }

        customButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(16)
            $0.top.equalTo(customTextField.snp.bottom).offset(10)
            $0.height.equalTo(50)
        }
        
        statusLabel.snp.makeConstraints {
            $0.center.equalTo(view.snp.center)
        }
    }
    
    func setButtonsConstraints() {
        buttonToPostView.translatesAutoresizingMaskIntoConstraints = false
        newButtonToPostView.translatesAutoresizingMaskIntoConstraints = false
        
        buttonToPostView.snp.makeConstraints {
            $0.leading.trailing.equalTo(stackView)
            $0.height.equalTo(50)
        }
        
        newButtonToPostView.snp.makeConstraints {
            $0.leading.trailing.equalTo(stackView)
        }
    }
    
    @objc private func saveCustomWord() {
        customWord = customTextField.text ?? ""
    }
}

