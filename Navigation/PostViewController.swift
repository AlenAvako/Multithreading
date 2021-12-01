//
//  PostViewController.swift
//  Navigation
//
//  Created by Ален Авако on 10.09.2021.
//

import UIKit

class PostViewController: UIViewController {
    
    var postTitle: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.75, green: 0.83, blue: 0.95, alpha: 1.00)
        title = postTitle
        openInfo()
    }
    
    func openInfo() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNew))
    }

    @objc func addNew() {
        let infoVC = InfoViewController()
        self.present(infoVC, animated: true, completion: nil)
    }
}
