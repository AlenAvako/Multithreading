//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Ален Авако on 14.09.2021.
//

import UIKit

class ProfileHeaderView: UITableViewHeaderFooterView, UITextFieldDelegate {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var statusText: String = ""
    
    static let id = "ProfileHeaderView"
    
    lazy var backgroudForAvatar: UIView = {
        let background = UIView()
        background.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        background.backgroundColor = .black
        background.alpha = 0
        return background
    }()
    
    lazy var xMarkButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(origin: CGPoint(x: UIScreen.main.bounds.maxX - 40, y: 20), size: CGSize(width: 30, height: 30))
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        button.alpha = 0
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.closeAvatar))
        button.addGestureRecognizer(gesture)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    //        MARK: Profile image
    lazy var profileImage: UIImageView = {
        let profileImage = UIImageView()
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.image = UIImage(named: "Ava")
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.layer.borderWidth = 3
        profileImage.layer.cornerRadius = 50
        profileImage.clipsToBounds = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.openAvatar))
        profileImage.addGestureRecognizer(gesture)
        profileImage.isUserInteractionEnabled = true
        return profileImage
    }()
    //        MARK: Status button
    lazy var getStatusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self,
                         action: #selector(getStatus(sender:)),
                         for: .touchUpInside)
        button.backgroundColor = UIColor(named: "appBlue")
        button.setTitle("Set status", for: .normal)
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.cornerRadius = 4
        return button
        
        
    }()
    //        MARK: Status Label
    lazy var nameLabel: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "Clint Barton"
        name.font = UIFont.systemFont(ofSize: 18,
                                      weight: .bold)
        name.textColor = .black
        return name
    }()
    
    //        MARK: Add status text field
    lazy var statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.text = "Waiting for something"
        statusLabel.font = UIFont.systemFont(ofSize: 14,
                                             weight: .regular)
        statusLabel.textColor = .gray
        return statusLabel
    }()
    //        MARK: Add status text field
    lazy var addStatus: UITextField = {
        let addStatus = UITextField()
        addStatus.translatesAutoresizingMaskIntoConstraints = false
        addStatus.addTarget(self,
                            action: #selector(statusTextChanged(_:)),
                            for: .editingChanged)
        addStatus.backgroundColor = UIColor.white
        addStatus.textColor = UIColor.black
        addStatus.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        addStatus.indent(size: 10)
        addStatus.layer.borderColor = UIColor.black.cgColor
        addStatus.layer.borderWidth = 1
        addStatus.layer.cornerRadius = 12
        return addStatus
    }()
    
    func addView() {
        addStatus.delegate = self
        contentView.addSubviews(getStatusButton, nameLabel, statusLabel, addStatus, backgroudForAvatar, profileImage, xMarkButton)
        
        
        NSLayoutConstraint.activate([
            
            profileImage.widthAnchor.constraint(equalToConstant: 100),
            profileImage.heightAnchor.constraint(equalTo: profileImage.widthAnchor),
            profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leadingIndent),
            profileImage.topAnchor.constraint(equalTo: self.topAnchor, constant: leadingIndent),
            
            nameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
            
            getStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leadingIndent),
            getStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: trailingIndent),
            getStatusButton.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 42),
            getStatusButton.heightAnchor.constraint(equalToConstant: 50),
            
            statusLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 20),
            statusLabel.bottomAnchor.constraint(equalTo: addStatus.topAnchor, constant: -6),
            statusLabel.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: trailingIndent),
            
            addStatus.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 20),
            addStatus.bottomAnchor.constraint(equalTo: getStatusButton.topAnchor, constant: -10),
            addStatus.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: trailingIndent),
            addStatus.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func animateView(_ viewToAnimate: UIView) {
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.2, options: .curveEaseIn, animations: {
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
        }) { (_) in
            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
                viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }
    }
    
    // MARK: objc funcs
    @objc private func getStatus(sender: UIButton) {
        self.animateView(sender)
        if statusText.isEmpty {
            return
        } else {
            statusLabel.text = statusText
            addStatus.resignFirstResponder()
        }
    }
    
    @objc private func statusTextChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }
        statusText = text
    }
}

extension ProfileHeaderView {
    
    @objc func openAvatar(_ gesture: UITapGestureRecognizer) {
        
        UIView.animate(withDuration: 0.5, delay: 0) {
            self.backgroudForAvatar.alpha = 0.8
            self.profileImage.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
//            self.profileImage.frame = CGRect(origin: CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY), size: CGSize(width: 200, height: 200))
            self.profileImage.transform = CGAffineTransform(scaleX: self.frame.width / 100, y: self.frame.width / 100)
            self.profileImage.layer.borderWidth = 0
            self.profileImage.layer.cornerRadius = 0
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.5) {
            self.xMarkButton.alpha = 1
        }
    }
    
    @objc func closeAvatar(_ gesture: UITapGestureRecognizer) {
        
        UIView.animate(withDuration: 0.5) {
            self.backgroudForAvatar.alpha = 0
            self.xMarkButton.alpha = 0
            self.profileImage.center = CGPoint(x: 66, y: 66)
            self.profileImage.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.profileImage.layer.borderWidth = 3
            self.profileImage.layer.cornerRadius = 50
        }
    }

}
