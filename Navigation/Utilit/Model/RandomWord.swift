//
//  RandomWord.swift
//  Navigation
//
//  Created by Ален Авако on 20.01.2022.
//

import UIKit

enum CheckWord {
     case empty, correct, incorrect
 }

 class RandomWord {

     private var safeWord = "Пароль"

     func check(word: String, completion: (CheckWord) -> Void) {
         if word == "" {
             completion(.empty)
         } else if word == safeWord {
             completion(.correct)
         } else {
             completion(.incorrect)
         }
     }
 }
