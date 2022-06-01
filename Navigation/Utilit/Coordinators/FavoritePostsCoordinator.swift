//
//  FavoritePostsCoordinator.swift
//  Navigation
//
//  Created by Ален Авако on 31.05.2022.
//

import Foundation
import UIKit

class FavoritePostsCoordinator: Coordinator {
    private weak var navigationController: UINavigationController?
    private let viewControllerFactory: ControllerFactoryProtocol
    
    init(navigationController: UINavigationController, factory: ControllerFactoryProtocol) {
        self.navigationController = navigationController
        self.viewControllerFactory = factory
    }
    
    func start() {
        let viewController = viewControllerFactory.viewController(for: .favoritePost(viewModel: FavoritePostsViewModel())) as! FavoritePostsViewController
        navigationController?.setViewControllers([viewController], animated: false)
    }
}
