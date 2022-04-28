//
//  SignInViewController.swift
//  Navigation
//
//  Created by Ален Авако on 25.04.2022.
//

import UIKit

protocol SignInViewcontrollerDelegate: AnyObject {
    func firstPassword(firstPassword: String)
    
    func checkPasswords(secondPassword: String) -> Bool
    
    func signInNewUser(email: String, password: String, controller: UIViewController)
}

class SignInViewController: UIViewController {
    
    weak var delegate: SignInViewcontrollerDelegate?
    
    private let signInInspector = SignInInspector()
    
    private let signInView = SignInView()

    override func loadView() {
        super.loadView()
        
        view = signInView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = signInInspector
        
        signInNewUser()
    }
    
    private func signInNewUser() {
        
        signInView.emailTextField.delegate = self
        signInView.firstPasswordTextField.delegate = self
        signInView.secondPasswordTextField.delegate = self
        
        signInView.firstPasswordTextField.addTarget(self, action: #selector(getPassword(_:)), for: .editingChanged)
        
        signInView.secondPasswordTextField.addTarget(self, action: #selector(checkPasswords(_:)), for: .editingChanged)
        
        signInView.doneButton.tapButton = { [weak self] in
            guard let email = self?.signInView.emailTextField.text, let password = self?.signInView.secondPasswordTextField.text, password != "" else { return }
            
            guard let controller = self else { return }
            
            if email.isEmpty {
                print("ERROR")
            } else {
                self?.delegate?.signInNewUser(email: email, password: password, controller: controller)
            }
        }
    }
    
    @objc func getPassword(_ sender: UITextField) {
        guard let password = sender.text else { return }
        
        if password.count < 6 {
            sender.backgroundColor = UIColor(named: "systemAlertColor")
        } else {
            sender.backgroundColor = .systemGray6
            self.delegate?.firstPassword(firstPassword: password)
        }
    }
    
    @objc func checkPasswords(_ sender: UITextField) {
        guard let password = sender.text else { return }
        guard let isCorrect = self.delegate?.checkPasswords(secondPassword: password) else { return }
        
        if isCorrect {
            UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseInOut, animations: {
                self.signInView.doneButton.alpha = 1
            }, completion: nil)
        } else {
            signInView.doneButton.alpha = 0
        }
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.tag == 0 {
            let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField
            nextField?.becomeFirstResponder()
        } else if textField.tag == 1 {
            guard let text = textField.text else { return false }
            if text.count < 6 {
                textField.backgroundColor = UIColor(named: "systemAlertColor")
                textField.placeholder = "6 characters minimum"
                textField.text = ""
            } else {
                let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField
                textField.backgroundColor = .systemGray6
                nextField?.becomeFirstResponder()
            }
        } else if textField.tag == 2 {
            textField.resignFirstResponder()
            return true
        }
        return false
    }
}
