//
//  InfoViewController.swift
//  Navigation
//
//  Created by Ален Авако on 11.09.2021.
//

import UIKit

class InfoViewController: UIViewController {

    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 1.00, green: 0.95, blue: 0.74, alpha: 1.00)
        
        button.backgroundColor = UIColor(red: 0.75, green: 0.85, blue: 0.86, alpha: 1)
        button.frame = CGRect(x: 0, y: 0, width: 120, height: 50)
        button.center = view.center
        button.setTitle("PUSH", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(openAlert), for: .touchUpInside)
        view.addSubview(button)
    }
    

    @objc func openAlert() {
        let alert = UIAlertController(title: "PUSH", message: "The button", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: joke(_:))
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true, completion: nil)
    }

    func joke(_ action: UIAlertAction) {
        let alert = UIAlertController(title: "😳", message: "Are you seriously?", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: finalJoke(_:))
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true, completion: nil)
        print("DON'T PUSH IT")
    }
    
    func finalJoke(_ action: UIAlertAction) {
        let alert = UIAlertController(title: "🤯", message: "", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "BANG", style: .cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        print("YOU'VE FINALLY DONE IT")
    }
}
