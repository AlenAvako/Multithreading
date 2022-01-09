//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Ален Авако on 16.12.2021.
//

import UIKit

class CurrentUserService: UserService {
    var currentUser = User(name: "Alen Avako", avatar: "picture19", status: "Hello world")
    
    func checkUser(_ name: String) -> User {
        if name == self.currentUser.name {
            return self.currentUser
        }
        return User(name: "unknown", avatar: "unknown", status: "unknown")
    }
}
