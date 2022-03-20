//
//  CustomTimer.swift
//  Navigation
//
//  Created by Ален Авако on 15.02.2022.
//

import Foundation
import UIKit

class BackgroundTimer {
    private var timer = Timer()
    private var startTime = 0
    
    func startTimer(viewController: UIViewController) {
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.startTime += 1
            
            if self.startTime == 200 {
                self.openAlert(viewController: viewController)
                self.timer.invalidate()
            }
        }
        timer.fire()
    }
    
    private func openAlert(viewController: UIViewController) {
        let customAlert = CustomAlert.shared
        let alert = customAlert.createAlert(title: "Внимание", message: "", style: .alert, actionStyle: .destructive, actionHandler: { _ in
//            exit(0)
        })
        viewController.present(alert, animated: true, completion: nil)
    }
}
