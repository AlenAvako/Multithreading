//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Ален Авако on 11.10.2021.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    static let id = "PhotosCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(photo)
        setupConstraints()
    }
    
    private lazy var photo: UIImageView = {
        let photo = UIImageView()
        photo.toAutoLayout()
        photo.contentMode = .scaleToFill
        return photo
    }()
    
    public func configureCell(image: UIImage) {
        self.photo.image = image
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photo.topAnchor.constraint(equalTo: self.topAnchor),
            photo.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            photo.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            photo.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
