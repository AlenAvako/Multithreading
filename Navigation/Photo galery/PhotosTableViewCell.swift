//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Ален Авако on 09.10.2021.
//

import UIKit

protocol PhotosTableViewCellDelegate: AnyObject {
    func didSelectButton()
}

class PhotosTableViewCell: UITableViewCell {
    
    static let id =  "PhotosTableViewCell"
    
    weak var delegate: PhotosTableViewCellDelegate?

    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.toAutoLayout()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.spacing = 8
        return stack
    }()

    lazy var photosLabel: UILabel = {
        let photos = UILabel()
        photos.text = "Photos"
        photos.toAutoLayout()
        photos.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        photos.textColor = .black
        return photos
    }()

    lazy var firstImage: UIImageView = {
        let image = UIImageView()
        image.toAutoLayout()
        image.image = photosArray[0]
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 6
        return image
    }()

    lazy var secondImage: UIImageView = {
        let image = UIImageView()
        image.toAutoLayout()
        image.image = photosArray[1]
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 6
        return image
    }()

    lazy var thirdImage: UIImageView = {
        let image = UIImageView()
        image.toAutoLayout()
        image.image = photosArray[2]
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 6
        return image
    }()

    lazy var fourthImage: UIImageView = {
        let image = UIImageView()
        image.toAutoLayout()
        image.image = photosArray[3]
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 6
        return image
    }()

    lazy var arrowButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(openView), for: .touchUpInside)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.toAutoLayout()
        self.selectionStyle = .none
        
        contentView.addSubviews(photosLabel, arrowButton, stackView)
        stackView.addArrangedSubviews(firstImage, secondImage, thirdImage, fourthImage)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PhotosTableViewCell {
    func setupViews() {

        NSLayoutConstraint.activate([
            photosLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: viewsIndent),
            photosLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: viewsIndent),

            arrowButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: bottomIndent),
            arrowButton.centerYAnchor.constraint(equalTo: photosLabel.centerYAnchor),
            arrowButton.heightAnchor.constraint(equalToConstant: 24),
            arrowButton.widthAnchor.constraint(equalTo: arrowButton.heightAnchor),

            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: viewsIndent),
            stackView.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: viewsIndent),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: bottomIndent),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: bottomIndent),
            
            firstImage.widthAnchor.constraint(greaterThanOrEqualToConstant: (contentView.frame.width - 16) / 4),
            firstImage.heightAnchor.constraint(equalTo: firstImage.widthAnchor),

            secondImage.widthAnchor.constraint(greaterThanOrEqualToConstant: (contentView.frame.width - 16) / 4),
            secondImage.heightAnchor.constraint(equalTo: firstImage.widthAnchor),

            thirdImage.widthAnchor.constraint(greaterThanOrEqualToConstant: (contentView.frame.width - 16) / 4),
            thirdImage.heightAnchor.constraint(equalTo: firstImage.widthAnchor),

            fourthImage.widthAnchor.constraint(greaterThanOrEqualToConstant: (contentView.frame.width - 16) / 4),
            fourthImage.heightAnchor.constraint(equalTo: firstImage.widthAnchor),
            
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    @objc func openView() {
        self.delegate?.didSelectButton()
    }
}

fileprivate let viewsIndent: CGFloat = 12
fileprivate let bottomIndent: CGFloat = -12
fileprivate let betweenIndent: CGFloat = 8

