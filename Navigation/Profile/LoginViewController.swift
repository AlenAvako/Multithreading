//
//  LoginViewController.swift
//  Navigation
//
//  Created by Ален Авако on 28.09.2021.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func checkLogin(name: String, password: String) -> Bool
}

class LoginViewController: UIViewController {
    
    weak var delegate: LoginViewControllerDelegate?
    
    var isAuthorized: Bool?
    
    var userName: String?
    var userPassword: String?
    var userService: UserService = CurrentUserService()
    
    let loginInspector = LoginInspector()
    
    lazy var loginScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.toAutoLayout()
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.toAutoLayout()
        return contentView
    }()
    
    lazy var mainLogo: UIImageView = {
        let mainLogo = UIImageView()
        mainLogo.toAutoLayout()
        mainLogo.image = UIImage(named: "logo")
        mainLogo.contentMode = .scaleAspectFill
        return mainLogo
    }()
    
    lazy var nameAndPasswordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.toAutoLayout()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 0.5
        stackView.layer.cornerRadius = 10
        stackView.clipsToBounds = true
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(passwordTextField)
        return stackView
    }()
    
    lazy var nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.toAutoLayout()
        nameTextField.addTarget(self, action: #selector(userLogin(_:)), for: .editingChanged)
        nameTextField.backgroundColor = .systemGray6
        nameTextField.textColor = UIColor.black
        nameTextField.autocapitalizationType = .none
        nameTextField.font = UIFont.systemFont(ofSize: 16)
        nameTextField.indent(size: 15)
        nameTextField.placeholder = "Email or phone"
        nameTextField.returnKeyType = UIReturnKeyType.next
        nameTextField.layer.borderColor = UIColor.lightGray.cgColor
        nameTextField.layer.borderWidth = 0.5
        return nameTextField
    }()
    
    lazy var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.toAutoLayout()
        passwordTextField.addTarget(self, action: #selector(userPswrd(_:)), for: .editingChanged)
        passwordTextField.backgroundColor = .systemGray6
        passwordTextField.textColor = UIColor.black
        passwordTextField.autocapitalizationType = .none
        passwordTextField.font = UIFont.systemFont(ofSize: 16)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.indent(size: 15)
        passwordTextField.placeholder = "Password"
        passwordTextField.returnKeyType = UIReturnKeyType.done
        return passwordTextField
    }()
    
    lazy var LogInButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        button.setTitle("Log In", for: .normal)
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        self.delegate = loginInspector
        
        #if DEBUG
        userService = TestUserService()
        #endif
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keybordWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keybordWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func openProfileViewController(name: String?) {
        let profileVC = ProfileViewController(user: userService, name: name ?? "unknown")
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    private func logInPasswordAlert() {
        let alert = UIAlertController(title: "Вход не выполнен", message: "Неверный Логин или Пароль!", preferredStyle: .alert)
        let tryMore = UIAlertAction(title: "Попробовать еще", style: .default, handler: nil)
        alert.addAction(tryMore)
        self.present(alert, animated: true, completion: nil)
    }
    
//    MARK: objc func
    @objc private func tap() {
        if delegate?.checkLogin(name: userName ?? "", password: userPassword ?? "") ?? false {
            openProfileViewController(name: userName)
        } else {
            logInPasswordAlert()
        }
    }
    
    @objc private func userLogin(_ textField: UITextField) {
        guard let name = textField.text else { return }
        userName = name
    }
    
    @objc private func userPswrd(_ textField: UITextField) {
        guard let text = textField.text else { return }
        userPassword = text
    }
}

extension LoginViewController: UITextFieldDelegate {
    func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(loginScrollView)
        loginScrollView.keyboardDismissMode = .onDrag
        loginScrollView.addSubview(contentView)
        
        setupStackView()
        contentView.addSubviews(mainLogo, nameAndPasswordStackView, LogInButton)
        
        NSLayoutConstraint.activate([
            loginScrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            loginScrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            loginScrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            loginScrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: loginScrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: loginScrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: loginScrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: loginScrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: loginScrollView.widthAnchor),
            
            mainLogo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            mainLogo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            mainLogo.widthAnchor.constraint(equalToConstant: 100),
            mainLogo.heightAnchor.constraint(equalTo: mainLogo.widthAnchor),
            
            nameAndPasswordStackView.centerXAnchor.constraint(equalTo: loginScrollView.centerXAnchor),
            nameAndPasswordStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: leadingIndent),
            nameAndPasswordStackView.topAnchor.constraint(equalTo: mainLogo.bottomAnchor, constant: 120),
            nameAndPasswordStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: trailingIndent),
            nameAndPasswordStackView.heightAnchor.constraint(equalToConstant: 100),

            LogInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: leadingIndent),
            LogInButton.topAnchor.constraint(equalTo: nameAndPasswordStackView.bottomAnchor, constant: 16),
            LogInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: trailingIndent),
            LogInButton.heightAnchor.constraint(equalToConstant: 50),
            LogInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }
    
    func setupStackView() {

        nameTextField.delegate = self
        nameTextField.tag = 0
        passwordTextField.delegate = self
        passwordTextField.tag = 1
        
        NSLayoutConstraint.activate([
            nameTextField.leadingAnchor.constraint(equalTo: nameAndPasswordStackView.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: nameAndPasswordStackView.trailingAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),

            passwordTextField.leadingAnchor.constraint(equalTo: nameAndPasswordStackView.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: nameAndPasswordStackView.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            return true;
        }
        return false
    }
}

extension LoginViewController {
    
    @objc private func keybordWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            loginScrollView.contentInset.bottom = keyboardSize.height
            loginScrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc private func keybordWillHide() {
        loginScrollView.contentInset.bottom = .zero
        loginScrollView.verticalScrollIndicatorInsets = .zero
    }
}
