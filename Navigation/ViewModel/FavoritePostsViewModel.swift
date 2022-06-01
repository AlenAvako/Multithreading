//
//  FavoritePostsViewModel.swift
//  Navigation
//
//  Created by Ален Авако on 31.05.2022.
//

import Foundation
import StorageService

final class FavoritePostsViewModel {
    var onStateChanged: ((State) -> Void)?
    
    private(set) var state: State = .initial {
        didSet {
            onStateChanged?(state)
        }
    }
    
    private(set) var posts: [NewPost] = []
    private let coreDataService = CoreDataService()
    
    func send(_ action: FavoritePostsViewModel.Action) {
        switch action {
        case .viewWillAppear:
            state = .loading
            fetchPosts()
        }
    }
    
    private func fetchPosts() {
        self.posts = coreDataService.getFavoritePosts()
        self.state = .loaded
    }
}

extension FavoritePostsViewModel {
    enum State {
        case initial
        case loading
        case loaded
    }
    enum Action {
        case viewWillAppear
    }
}
