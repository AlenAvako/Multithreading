//
//  AuthService.swift
//  Navigation
//
//  Created by Ален Авако on 27.05.2022.
//

import Foundation


protocol AuthService {
    func login(email: String, password: String, completion: @escaping Handler)
    func createUser(email: String, password: String, completion: @escaping Handler)
    func signIn(email: String, password: String, completion: @escaping Handler)
    func signOut()
}
