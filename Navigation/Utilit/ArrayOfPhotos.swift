//
//  ArrayOfPhotos.swift
//  Navigation
//
//  Created by Ален Авако on 11.10.2021.
//

import UIKit

class PhotoArrayCreator {
    
    static let shared = PhotoArrayCreator()
    
    var photosArray: [UIImage] = []

    func createPhotosArray() {
        photosArray = (0...19).compactMap { UIImage(named: "picture\($0)")?.resizeWithWidth(width: 300) }
    }
    
    private init() {}
}
