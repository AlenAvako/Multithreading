//
//  CustomTimer.swift
//  Navigation
//
//  Created by Ален Авако on 16.02.2022.
//

import Foundation

class CustomTimer {
    
    private let arrayOfPosts = ["Hello", "World", "Swift", "Пароль"]
    
    private var timer = Timer()
    private var counter = 15
    private var timeString = ""
    
    func setTimer() -> String {
        self.counter -= 1
        let time = self.secondToMinutes(seconds: self.counter)
        self.timeString = self.makeTimeString(minutes: time.0, seconds: time.1)
        
        if counter == 0 {
            cancelTimer()
        }
        timer.fire()
        return timeString
    }
    
    func getRandomPost() -> String {
        let randomWord = arrayOfPosts.randomElement()
        return randomWord ?? ""
    }
    
    private func secondToMinutes(seconds: Int) -> (Int, Int) {
        return (((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    
    private func makeTimeString(minutes: Int, seconds: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", minutes)
        timeString += ":"
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
    private func cancelTimer() {
        timer.invalidate()
        self.counter = 15
    }
}
