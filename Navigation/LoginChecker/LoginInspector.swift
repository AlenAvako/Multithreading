//
//  LoginInspector.swift
//  Navigation
//
//  Created by Ален Авако on 02.01.2022.
//

import Firebase
import FirebaseAuth

class LoginInspector: LoginViewControllerDelegate {
    
    func checkLogin(name: String, password: String, completion: @escaping (Result<UserLogInResult, Error>) -> Void) {
        Auth.auth().signIn(withEmail: name, password: password) { [weak self] userData, error in
            if error != nil {
                guard let myError = error else { return }
                completion(.failure(myError))
            }
            
            if userData != nil {
                let fetchedData = UserLogInResult(name: "")
                completion(.success(fetchedData))
            }
        }
    }
    
    
    func checkUserForLogIn(user: UserService, name: String, controller: UIViewController) {
        
        if Auth.auth().currentUser != nil {
            openProfileVC(user: user, name: name, controller: controller)
        }
    }
    
    private func openProfileVC(user: UserService, name: String, controller: UIViewController) {
        let profileVC = ProfileViewController(user: user, name: name)
        controller.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    private func logInPasswordAlert(title: String, message: String, controller: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let tryMore = UIAlertAction(title: "Попробовать еще", style: .default, handler: nil)
        alert.addAction(tryMore)
        
        controller.present(alert, animated: true, completion: nil)
    }
}
