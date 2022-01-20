//
//  RandomWord.swift
//  Navigation
//
//  Created by Ален Авако on 20.01.2022.
//

import UIKit

enum CheckWorld {
     case empty, correct, incorrect
 }

 class RandomWord {

     private var safeWord = "Пароль"

     func check(word: String, completion: (CheckWorld) -> Void) {
         if word == "" {
             completion(.empty)
         } else if word == safeWord {
             completion(.correct)
         } else {
             completion(.incorrect)
         }
     }
 }
