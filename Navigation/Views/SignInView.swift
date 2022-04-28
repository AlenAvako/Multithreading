//
//  SignInView.swift
//  Navigation
//
//  Created by Ален Авако on 26.04.2022.
//

import UIKit

class SignInView: UIView {
    
    lazy var signInLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "SIGN IN"
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.textAlignment = .center
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.toAutoLayout()
        textField.backgroundColor = .systemGray6
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.indent(size: 15)
        textField.autocapitalizationType = .none
        textField.placeholder = "email, example: ***@gmail.com"
        textField.returnKeyType = .next
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        return textField
    }()
    
    lazy var firstPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.toAutoLayout()
        textField.backgroundColor = .systemGray6
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.indent(size: 15)
        textField.autocapitalizationType = .none
        textField.placeholder = "enter password"
        textField.returnKeyType = .next
        textField.textContentType = .oneTimeCode
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        return textField
    }()
    
    lazy var secondPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.toAutoLayout()
        textField.backgroundColor = .systemGray6
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.indent(size: 15)
        textField.autocapitalizationType = .none
        textField.placeholder = "repeat password"
        textField.returnKeyType = .done
        textField.isSecureTextEntry = true
        textField.passwordRules = .none
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        return textField
    }()
    
    lazy var doneButton: CustomButton = {
        let button = CustomButton(color: "colorSuper", title: "Done", titleColor: .white, cornerRadius: 10)
        button.toAutoLayout()
        button.alpha = 0
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubviews(signInLabel, emailTextField, firstPasswordTextField, secondPasswordTextField, doneButton)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {

        emailTextField.tag = 0
        firstPasswordTextField.tag = 1
        secondPasswordTextField.tag = 2
        
        NSLayoutConstraint.activate([
            signInLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            signInLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 32),
            emailTextField.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -32),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            emailTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            firstPasswordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            firstPasswordTextField.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -32),
            firstPasswordTextField.heightAnchor.constraint(equalToConstant: 50),
            firstPasswordTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            secondPasswordTextField.topAnchor.constraint(equalTo: firstPasswordTextField.bottomAnchor, constant: 16),
            secondPasswordTextField.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -32),
            secondPasswordTextField.heightAnchor.constraint(equalToConstant: 50),
            secondPasswordTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            doneButton.topAnchor.constraint(equalTo: secondPasswordTextField.bottomAnchor, constant: 32),
            doneButton.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -32),
            doneButton.heightAnchor.constraint(equalToConstant: 50),
            doneButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}

//extension SignInView: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        
//        if textField.tag == 0 {
//            let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField
//            nextField?.becomeFirstResponder()
//        } else if textField.tag == 1 {
//            guard let text = textField.text else { return false }
//            if text.count < 6 {
//                textField.backgroundColor = UIColor(named: "systemAlertColor")
//                textField.placeholder = "6 characters minimum"
//                textField.text = ""
//            } else {
//                let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField
//                textField.backgroundColor = .systemGray6
//                guard let password = textField.text else { return false }
//
//                nextField?.becomeFirstResponder()
//            }
//        } else {
//            textField.resignFirstResponder()
//            return true
//        }
//        return false
//    }
//}
