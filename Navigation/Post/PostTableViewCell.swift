//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Ален Авако on 08.10.2021.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    static let id =  "PostTableViewCell"
    
    public func configureCell(title: String, image: String, description: String, likes: Int, views: Int) {
        self.nameLabel.text = title
        self.postImage.image = UIImage(named: image)
        self.descriptionLabel.text = description
        self.numberOfLikes.text = "Likes: \(likes)"
        self.numberOfViews.text = "Views: \(views)"
    }
    
    lazy var nameLabel: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        name.textColor = .black
        name.numberOfLines = 2
        return name
    }()
    
    lazy var postImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .black
        return image
    }()
    
    lazy var descriptionLabel: UILabel = {
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        description.textColor = .systemGray
        description.numberOfLines = 0
        return description
    }()
    
    lazy var numberOfLikes: UILabel = {
        let likes = UILabel()
        likes.translatesAutoresizingMaskIntoConstraints = false
        likes.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        likes.textColor = .black
        return likes
    }()
    
    lazy var numberOfViews: UILabel = {
        let views = UILabel()
        views.translatesAutoresizingMaskIntoConstraints = false
        views.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        views.textColor = .black
        return views
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PostTableViewCell {
    private func setupViews() {
        contentView.addSubviews(nameLabel, postImage, descriptionLabel, numberOfLikes, numberOfViews)
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: leadingIndent),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: trailingIndent),
            
            postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            postImage.heightAnchor.constraint(equalTo: postImage.widthAnchor),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: leadingIndent),
            descriptionLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: trailingIndent),
            
            numberOfLikes.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: leadingIndent),
            numberOfLikes.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            
            numberOfViews.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: trailingIndent),
            numberOfViews.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            numberOfViews.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
