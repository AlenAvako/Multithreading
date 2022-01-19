//
//  FeedViewController.swift
//  Navigation
//
//  Created by Ален Авако on 10.09.2021.
//

import UIKit

class FeedViewController: UIViewController {

    let buttonToPostView = CustomButton(color: "colorSuper", title: "Hello", titleColor: .white, cornerRadius: 4)
    let newButtonToPostView = CustomButton(color: "colorSuper", title: "World", titleColor: .white, cornerRadius: 4)
    
    let post = Post(title: "Новости")
    
    let stackView = UIStackView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Feed"
        self.view.backgroundColor = UIColor(red: 1.00, green: 0.95, blue: 0.74, alpha: 1.00)
        
        configureStackView()
    }
    
//    MARK: configure
    func configureStackView() {
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        
        setStackViewConstraint()
        addButtonToStackView()
    }
    
    func configurePostViewButton() {
        buttonToPostView.tapButton = { [ weak self ] in
            let postVC = PostViewController()
            postVC.postTitle = self?.post.title
            self?.navigationController?.pushViewController(postVC, animated: true)
        }
        
        newButtonToPostView.tapButton = { [ weak self ] in
            let postVC = PostViewController()
            postVC.postTitle = self?.post.title
            self?.navigationController?.pushViewController(postVC, animated: true)
        }
        
        setButtonsConstraints()
    }
    
    func addButtonToStackView() {
        stackView.addArrangedSubview(buttonToPostView)
        stackView.addArrangedSubview(newButtonToPostView)
        
        configurePostViewButton()
    }
//    MARK: constraints
    func setStackViewConstraint() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),

        ])
    }
    
    func setButtonsConstraints() {
        buttonToPostView.translatesAutoresizingMaskIntoConstraints = false
        newButtonToPostView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            buttonToPostView.leadingAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.leadingAnchor, constant: leadingIndent),
            buttonToPostView.trailingAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.trailingAnchor, constant: trailingIndent),
            buttonToPostView.heightAnchor.constraint(equalToConstant: 50),

            newButtonToPostView.leadingAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.leadingAnchor, constant: leadingIndent),
            newButtonToPostView.trailingAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.trailingAnchor, constant: trailingIndent),
            newButtonToPostView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

