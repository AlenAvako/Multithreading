//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Ален Авако on 14.09.2021.
//

import SnapKit

class ProfileHeaderView: UITableViewHeaderFooterView, UITextFieldDelegate {
    
    static let id = "ProfileHeaderView"
    
    private var statusText: String = ""
    
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
        profileImage.toAutoLayout()
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
    lazy var getStatusButton: CustomButton = {
        let button = CustomButton(color: "colorSuper", title: "Set status", titleColor: .white, cornerRadius: 4)
        button.toAutoLayout()
        return button
        
        
    }()
    //        MARK: Status Label
    lazy var nameLabel: UILabel = {
        let name = UILabel()
        name.toAutoLayout()
        name.text = "Clint Barton"
        name.font = UIFont.systemFont(ofSize: 18,
                                      weight: .bold)
        name.textColor = .black
        return name
    }()
    
    //        MARK: Add status text field
    lazy var statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.toAutoLayout()
        statusLabel.text = "Waiting for something"
        statusLabel.font = UIFont.systemFont(ofSize: 14,
                                             weight: .regular)
        statusLabel.textColor = .gray
        return statusLabel
    }()
    //        MARK: Add status text field
    lazy var addStatus: UITextField = {
        let addStatus = UITextField()
        addStatus.toAutoLayout()
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
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addView() {
        getStatusButton.tapButton = {
            self.getStatus()
        }
        
        addStatus.delegate = self
        contentView.addSubviews(getStatusButton, nameLabel, statusLabel, addStatus, backgroudForAvatar, profileImage, xMarkButton)
        
        profileImage.snp.makeConstraints {
            $0.leading.top.equalTo(self).offset(leadingIndent)
            $0.size.equalTo(CGSize(width: 100, height: 100))
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImage.snp.trailing).offset(20)
            $0.top.equalTo(self).offset(27)
        }
        
        getStatusButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(self).inset(16)
            $0.top.equalTo(profileImage.snp.bottom).offset(42)
            $0.height.equalTo(50)
        }
        
        statusLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImage.snp.trailing).offset(20)
            $0.bottom.equalTo(addStatus.snp.top).offset(-6)
        }
        
        addStatus.snp.makeConstraints {
            $0.leading.equalTo(profileImage.snp.trailing).offset(20)
            $0.trailing.equalTo(self).inset(16)
            $0.bottom.equalTo(getStatusButton.snp.top).offset(-10)
            $0.height.equalTo(40)
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func getStatus() {
        if statusText.isEmpty {
            return
        } else {
            statusLabel.text = statusText
            addStatus.resignFirstResponder()
            addStatus.text?.removeAll()
        }
    }
    
    // MARK: objc funcs
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
