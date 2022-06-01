//
//  FirstLoginFactory.swift
//  Navigation
//
//  Created by Ален Авако on 08.01.2022.
//

import UIKit

class FirstLoginFactory: LoginFactory {
    static let firstLoginFactory = FirstLoginFactory()
    
    func addLoginFactory() -> LoginInspector {
        return LoginInspector()
    }
}
