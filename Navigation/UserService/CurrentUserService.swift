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
        guard name == self.currentUser.name else { return User(name: "unknown", avatar: "notFound", status: "unknown") }

        return currentUser
    }
}
