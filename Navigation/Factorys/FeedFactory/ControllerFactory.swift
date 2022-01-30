//
//  ControllerFactory.swift
//  Navigation
//
//  Created by Ален Авако on 26.01.2022.
//

import UIKit

protocol ControllerFactory {
    func makeFeed() -> FeedViewController
}

class ControllerFactoryImplementation: ControllerFactory {
    func makeFeed() -> FeedViewController {
        let checker = RandomWord()
        let viewModel = FeedViewModel(checker: checker)
        let feedVC = FeedViewController(viewModel: viewModel)
        return feedVC
    }
}
