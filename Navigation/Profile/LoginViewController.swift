//
//  LoginViewController.swift
//  Navigation
//
//  Created by Ален Авако on 28.09.2021.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func checkLogin(name: String, password: String, completion: @escaping (Result<UserLogInResult, Error>) -> Void)
    
    func checkUserForLogIn(user: UserService, name: String, controller: UIViewController)
}

final class LoginViewController: UIViewController {
    
    weak var delegate: LoginViewControllerDelegate?
    
    var loginFactory: FirstLoginFactory?
    
    var userService: UserService = CurrentUserService()
    
    let loginInspector = LoginInspector()
    
    let bruteForce = BruteForce()
    
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
    
    lazy var LogInButton: CustomButton = {
        let button = CustomButton(color: "colorSuper", title: "Log In", titleColor: .white, cornerRadius: 10)
        button.toAutoLayout()
        button.tapButton = { [self] in
            guard let name = nameTextField.text, let password = passwordTextField.text, name != "", password != "" else {
                logInPasswordAlert(title: "Внимание!", message: "Логин или пароль не заполнены, попробуйте снова или зарегестрируйтесь.")
                return
            }
            
            delegate?.checkLogin(name: name, password: password) { [weak self] result in
                switch result {
                case .success(let data):
                    self?.openProfileVC(name: "")
                case .failure(let error):
                    let alert = CustomAlert.shared.createAlert(title: error.localizedDescription, message: "", style: .alert)
                    self?.present(alert, animated: true)
                }
            }
        }
        button.clipsToBounds = true
        button.alpha = 1
        if button.isSelected || !button.isEnabled || button.isHighlighted { button.alpha = 0.8 }
        return button
    }()
    
    lazy var passwordButtonPicker: CustomButton = {
        let button = CustomButton(color: "colorSuper", title: "Подобрать пароль", titleColor: .white, cornerRadius: 10)
        button.toAutoLayout()
        button.tapButton = { [weak self] in
            self?.activityIndicator.startAnimating()
            self?.activityIndicator.isHidden = false
            self?.passwordTextField.indent(size: 35)
            self?.passwordTextField.placeholder = "Hacking password"
            DispatchQueue.global().async {
                self?.bruteForce.bruteForce(passwordToUnlock: "12312")
                DispatchQueue.main.async {
                    self?.activityIndicator.isHidden = true
                    self?.activityIndicator.stopAnimating()
                    self?.passwordTextField.text = self?.bruteForce.hackedPassword
                    self?.passwordTextField.indent(size: 15)
                    self?.passwordTextField.placeholder = "Password"
                }
            }
        }
        button.clipsToBounds = true
        button.alpha = 1
        if button.isSelected || !button.isEnabled || button.isHighlighted { button.alpha = 0.8 }
        return button
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.toAutoLayout()
        indicator.style = .medium
        return indicator
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkUser()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func logInPasswordAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okButton)
        
        let signInButton = UIAlertAction(title: "Sign in", style: .default) { [weak self] action in
            let singInVC = SignInViewController()
            self?.navigationController?.pushViewController(singInVC, animated: true)
        }
        alert.addAction(signInButton)
                                         
        self.present(alert, animated: true, completion: nil)
    }
    
    private func openProfileVC(name: String) {
        let profileVC = ProfileViewController(user: userService, name: name)
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    private func checkUser() {
        delegate?.checkUserForLogIn(user: userService, name: "", controller: self)
    }
    
    private func setupViews() {
        
        view.backgroundColor = .white
        
        view.addSubview(loginScrollView)
        loginScrollView.keyboardDismissMode = .onDrag
        loginScrollView.addSubview(contentView)
        
        setupStackView()
        contentView.addSubviews(mainLogo, nameAndPasswordStackView, LogInButton, passwordButtonPicker, activityIndicator)
        
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
            
            passwordButtonPicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            passwordButtonPicker.topAnchor.constraint(equalTo: LogInButton.bottomAnchor, constant: 10),
            passwordButtonPicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            passwordButtonPicker.heightAnchor.constraint(equalToConstant: 50),
            passwordButtonPicker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            
            activityIndicator.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor, constant: 10),
            activityIndicator.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor)
        ])
    }
    
    private func setupStackView() {
        
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
