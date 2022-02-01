//
//  Coordinator.swift
//  Navigation
//
//  Created by Ален Авако on 26.01.2022.
//

import UIKit

protocol Coordinator: AnyObject {
    var coordinators: [Coordinator] { get set }
}
