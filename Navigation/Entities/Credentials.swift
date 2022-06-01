//
//  Credentials.swift
//  Navigation
//
//  Created by Ален Авако on 27.05.2022.
//

import Foundation
import RealmSwift

class Credentials: Object {
    @objc dynamic var email = ""
    @objc dynamic var password = ""
}
