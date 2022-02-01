//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Ален Авако on 26.01.2022.
//

import UIKit

enum CheckMyResult {
    case excellent, bad, fault
}

protocol FeedViewOutput {
    func updateText(_ text: String, completion: (CheckMyResult) -> Void)
}

class FeedViewModel: FeedViewOutput {
    
    var checker: RandomWord
    
    init(checker: RandomWord) {
        self.checker = checker
    }
    
    func updateText(_ text: String, completion: (CheckMyResult) -> Void) {
        let checkText = text
        checker.check(word: checkText) { cheking in
            switch cheking {
            case .empty:
                completion(.fault)
            case .correct:
                completion(.excellent)
            case .incorrect:
                completion(.bad)
            }
            
        }
    }
}
