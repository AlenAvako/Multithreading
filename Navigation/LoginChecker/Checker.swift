//
//  Checker.swift
//  Navigation
//
//  Created by Ален Авако on 02.01.2022.
//

import Foundation

class Checker {
    
    static let shared = Checker()
    
    private var password: String?
    
    var isCorrect: Bool = false
    
    func getFirstPassword(firstPassword: String) {
        self.password = firstPassword
    }
    
    func checker(second: String) {
        isCorrect = password == second
    }
    
    private init() {}
}
