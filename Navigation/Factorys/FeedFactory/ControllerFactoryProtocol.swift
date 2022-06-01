//
//  ControllerFactory.swift
//  Navigation
//
//  Created by Ален Авако on 26.01.2022.
//

import UIKit

enum ViewControllers {
    case feed(viewModel: FeedViewModel)
    case favoritePost(viewModel: FavoritePostsViewModel)
    
    func makeViewController() -> UIViewController {
        switch self {
        case .feed(let viewModel):
            return FeedViewController(viewModel: viewModel)
        case .favoritePost(let viewModel):
            return FavoritePostsViewController(viewModel: viewModel)
        }
    }
}

protocol ControllerFactoryProtocol {
    func viewController(for viewController: ViewControllers) -> UIViewController
}

class ControllerFactoryImplementation: ControllerFactoryProtocol {
    func viewController(for enumOfVC: ViewControllers) -> UIViewController {
        return enumOfVC.makeViewController()
    }
}
