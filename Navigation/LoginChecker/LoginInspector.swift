//
//  LoginInspector.swift
//  Navigation
//
//  Created by Ален Авако on 02.01.2022.
//

import UIKit

class LoginInspector: LoginViewControllerDelegate {
    let checker = Checker.shared
    
    func checkLogin(name: String, password: String) -> Bool {
        checker.checker(name: name, password: password)
        
        return checker.isAuthorized
    }
}
