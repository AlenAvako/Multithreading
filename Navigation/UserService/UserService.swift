//
//  UserService.swift
//  Navigation
//
//  Created by Ален Авако on 16.12.2021.
//

import UIKit

protocol UserService {
    func checkUser(_ name: String) -> User
}
