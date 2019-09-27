//
//  PhotoCollectionViewCell.swift
//  Whats For Dinner
//
//  Created by Isaac Delgado on 9/26/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var imageView: UIImageView!
    
    // MARK: - Config
    func configurePhoto(_ photo: Photo) {
        if let photoURL = URL(string: photo.url ?? "") {
            imageView.kf.setImage(with: photoURL)
        }
    }
}
