//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Ален Авако on 26.01.2022.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var coordinators: [Coordinator] = []
    let tabBarController = UITabBarController()
    private let factory = ControllerFactoryImplementation()
    
    init() {
        let feedCoordinator = configureFeed()
        let logInCoordinator = configureLogIn()
        
        tabBarController.viewControllers = [ feedCoordinator.navigationController, logInCoordinator ]
        
        feedCoordinator.start()
    }
    
    private func configureFeed() -> FeedFlowCoordinator {
        let feedVC = UINavigationController()
        let feedIcon = UIImage(named: "lenta")
        feedVC.tabBarItem = UITabBarItem(title: "feed", image: feedIcon, tag: 1)
        let coordinator = FeedFlowCoordinator(navigationController: feedVC, factory: factory)
        return coordinator
    }
    
    private func configureLogIn() -> UINavigationController {
        let loginVC = LoginViewController()
        let loginView = UINavigationController(rootViewController: loginVC)
        let loginIcon = UIImage(systemName: "person.fill")
        loginVC.tabBarItem = UITabBarItem(title: "Profile", image: loginIcon, tag: 0)
        return loginView
    }

}
