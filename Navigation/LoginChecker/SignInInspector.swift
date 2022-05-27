//
//  SignInInspector.swift
//  Navigation
//
//  Created by Ален Авако on 26.04.2022.
//

import Firebase
import FirebaseAuth

class SignInInspector: SignInViewcontrollerDelegate {
    private let checker = Checker.shared
    
    func firstPassword(firstPassword: String) {
        checker.getFirstPassword(firstPassword: firstPassword)
    }
    
    func checkPasswords(secondPassword: String) -> Bool {
        checker.checker(second: secondPassword)

        return checker.isCorrect
    }
    
    func signInNewUser(email: String, password: String, controller: UIViewController) {
        Auth.auth().createUser(withEmail: email, password: password) { data, error in
            if error != nil {
                let present = CustomAlert.shared
                let alert = present.createAlert(title: error!.localizedDescription, message: "Try yourmail@vk.com", style: .alert, actionStyle: .default, actionHandler: nil)
                controller.present(alert, animated: true, completion: nil)
            }
            
            if data != nil {
                guard let email = data?.user.email else  { return }
                
                let present = CustomAlert.shared
                
                let alert = present.createAlert(title: email, message: "SIGNED IN", style: .alert, actionStyle: .default) { action in
                    controller.navigationController?.popViewController(animated: true)
                }
                controller.present(alert, animated: true, completion: nil)
            }
        }
    }
}
