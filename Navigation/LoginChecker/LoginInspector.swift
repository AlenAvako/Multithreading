//
//  LoginInspector.swift
//  Navigation
//
//  Created by Ален Авако on 02.01.2022.
//

import Firebase
import FirebaseAuth

class LoginInspector: LoginViewControllerDelegate {
    
    private var loginService: LoginService = .realm
    
    func login(inputLogin: String, inputPassword: String, completion: @escaping Handler) {
        loginService.current.login(email: inputLogin, password: inputPassword, completion: completion)
    }
    
    func signOut() {
        loginService.current.signOut()
    }
}
