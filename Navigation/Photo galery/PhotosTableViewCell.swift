//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Ален Авако on 09.10.2021.
//

import UIKit
import SnapKit

protocol PhotosTableViewCellDelegate: AnyObject {
    func didSelectButton()
}

class PhotosTableViewCell: UITableViewCell {
    
    static let id = "PhotosTableViewCell"
    
    weak var delegate: PhotosTableViewCellDelegate?
    
    private let photoArray = [
        UIImage(named: "picture0"),
        UIImage(named: "picture1"),
        UIImage(named: "picture2"),
        UIImage(named: "picture3"),
        UIImage(named: "picture4"),
        UIImage(named: "picture5"),
        UIImage(named: "picture6"),
        UIImage(named: "picture7"),
    ]

    lazy var photosLabel: UILabel = {
        let photos = UILabel()
        photos.text = "Photos"
        photos.toAutoLayout()
        photos.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        photos.textColor = .black
        return photos
    }()
    
    lazy var photosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.toAutoLayout()
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.id)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
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
        self.selectionStyle = .none
        
        photosCollectionView.dataSource = self
        photosCollectionView.delegate = self
        
        contentView.addSubviews(photosLabel, arrowButton, photosCollectionView)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PhotosTableViewCell {
    func setupViews() {
        photosLabel.snp.makeConstraints {
            $0.top.leading.equalTo(self.contentView).offset(viewsIndent)
        }
        
        arrowButton.snp.makeConstraints {
            $0.trailing.equalTo(self.contentView.snp.trailing).offset(-12)
            $0.centerY.equalTo(photosLabel.snp.centerY)
            $0.height.width.equalTo(24)
        }
        
        photosCollectionView.snp.makeConstraints {
            $0.top.equalTo(photosLabel.snp.bottom).offset(viewsIndent)
            $0.leading.trailing.bottom.equalTo(self.contentView)
            $0.height.equalTo(100)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    @objc func openView() {
        self.delegate?.didSelectButton()
    }
}

extension PhotosTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.id, for: indexPath) as! PhotosCollectionViewCell
        cell.configureCell(image: photoArray[indexPath.row]!)
        cell.contentView.roundCornersWithRadius(6)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt IndexPath: IndexPath) -> CGSize {
        let width: CGFloat
        let height: CGFloat
        width = (collectionView.frame.width - viewsIndent * 2 - 8 * 3)/4
        height = collectionView.frame.height - viewsIndent * 2
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: viewsIndent, bottom: viewsIndent, right: viewsIndent)
    }
}

fileprivate let viewsIndent: CGFloat = 12
fileprivate let bottomIndent: CGFloat = -12
fileprivate let betweenIndent: CGFloat = 8

