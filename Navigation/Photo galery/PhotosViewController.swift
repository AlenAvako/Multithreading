//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Ален Авако on 11.10.2021.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
    let photoArray = PhotoArrayCreator.shared
    
    let facade = ImagePublisherFacade()
    
    var newPhotosArray: [UIImage] = []

    lazy var photosCollectionView: UICollectionView = {
        let photoCollectionLayout = UICollectionViewFlowLayout()
        photoCollectionLayout.scrollDirection = .vertical
        let photosCollection = UICollectionView(frame: .zero, collectionViewLayout: photoCollectionLayout)
        photosCollection.toAutoLayout()
        photosCollection.backgroundColor = .white
        photosCollection.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.id)
        return photosCollection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(photosCollectionView)
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        facade.subscribe(self)
        setupConstraints()
        
        photoArray.createPhotosArray()
        
        navigationController?.navigationBar.isHidden = false
        self.title = "Photo Gallery"
        
        facade.addImagesWithTimer(time: 1, repeat: 10, userImages: photoArray.photosArray)
    }
    
    deinit {
        facade.rechargeImageLibrary()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photosCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            photosCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photosCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photosCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newPhotosArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photosCollectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.id, for: indexPath) as! PhotosCollectionViewCell
        cell.configureCell(image: newPhotosArray[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 3
        let paddindWidth = 8 * (itemsPerRow + 1)
        let accessibleWidth = collectionView.frame.width - paddindWidth
        let widthPerItem = accessibleWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}

extension PhotosViewController: ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
        newPhotosArray = images
        photosCollectionView.reloadData()
    }
}
