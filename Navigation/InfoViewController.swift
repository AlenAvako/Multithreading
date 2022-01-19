//
//  InfoViewController.swift
//  Navigation
//
//  Created by Ален Авако on 11.09.2021.
//

import UIKit

class InfoViewController: UIViewController {

    lazy var button: CustomButton = {
        let button = CustomButton(color: "appBlue", title: "PushMe", titleColor: .black, cornerRadius: 4)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .cyan
        view.addSubview(button)
        
       configureButton()
    }
    
    fileprivate func configureButton() {
        button.frame = CGRect(x: 0, y: 0, width: 120, height: 50)
        button.center = view.center
        button.tapButton = { [ weak self ] in
            self?.openAlert()
        }
    }
    
    func openAlert() {
        let alert = UIAlertController(title: "PUSH", message: "The button", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true, completion: nil)
    }
}

