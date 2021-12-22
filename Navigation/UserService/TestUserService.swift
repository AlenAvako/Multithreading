//
//  TestUserService.swift
//  Navigation
//
//  Created by Ален Авако on 20.12.2021.
//

import UIKit

class TestUserService: UserService {
    var testUser = User(name: "Natasha Romanoff", avatar: "picture4", status: "Privet!")
    
    func checkUser(_ name: String) -> User {
        return testUser
    }
}
