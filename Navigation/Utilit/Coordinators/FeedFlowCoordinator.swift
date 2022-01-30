//
//  FeedFlowCoordinator.swift
//  Navigation
//
//  Created by Ален Авако on 26.01.2022.
//

import UIKit

class FeedFlowCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    let navigationController: UINavigationController
    private let factory: ControllerFactory
    
    init(navigationController: UINavigationController, factory: ControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func start() {
        let feedController = factory.makeFeed()
        navigationController.pushViewController(feedController, animated: true)
    }
}
