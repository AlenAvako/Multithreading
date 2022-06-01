//
//  CustomAlert.swift
//  Navigation
//
//  Created by Ален Авако on 15.02.2022.
//

import Foundation
import UIKit

final class CustomAlert {
    static let shared = CustomAlert()
    
    private init() {}
    
    func createAlert(title: String, message: String, style: UIAlertController.Style, actionStyle: UIAlertAction.Style = .default, actionHandler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        alert.addAction(UIAlertAction(title: "OK", style: actionStyle, handler: actionHandler))
        return alert
    }
}
