//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Ален Авако on 26.01.2022.
//

import UIKit

class AppCoordinator: Coordinator {
    private let factory: ControllerFactoryProtocol
    private let tabBarController = UITabBarController()
    private var window: UIWindow?
    private let scene: UIWindowScene
    
    init(scene: UIWindowScene, factory: ControllerFactoryProtocol) {
        self.scene = scene
        self.factory = factory
    }
    
    func start() {
        initWindow()
        initTabBarController()
    }
    
    private func initWindow() {
        let window = UIWindow(windowScene: scene)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        self.window = window
    }
    
    private func initTabBarController() {
        tabBarController.viewControllers = setUpViewControllers()
    }
    
    private func setUpViewControllers() -> [UIViewController] {
        let checker = RandomWord()
        let feedVC = factory.viewController(for: .feed(viewModel: FeedViewModel(checker: checker)))
        let icon = UIImage(named: "lenta")
        let feedNC = configureNavController(for: feedVC, title: "feed", image: icon!)
        
        let loginVC = LoginViewController()
        let loginNC = configureNavController(for: loginVC, title: "profile", image: UIImage(systemName: "person.fill")!)
        
        let favoriteVC = factory.viewController(for: .favoritePost(viewModel: FavoritePostsViewModel()))
        let favoriteNC = configureNavController(for: favoriteVC, title: "favorite", image: UIImage(systemName: "heart")!)
        
        return [feedNC, loginNC, favoriteNC]
    }
    
    private func configureNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = false
        rootViewController.navigationItem.title = title
        return navController
    }
}
