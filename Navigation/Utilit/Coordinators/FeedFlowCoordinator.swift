//
//  FeedFlowCoordinator.swift
//  Navigation
//
//  Created by Ален Авако on 26.01.2022.
//

import UIKit

class FeedFlowCoordinator: Coordinator {
    let navigationController: UINavigationController
    private let factory: ControllerFactoryProtocol
    
    init(navigationController: UINavigationController, factory: ControllerFactoryProtocol) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func start() {
        let checker = RandomWord()
        let viewModel = FeedViewModel(checker: checker)
        let feedController = factory.viewController(for: .feed(viewModel: viewModel)) as! FeedViewController
        navigationController.pushViewController(feedController, animated: true)
    }
}
