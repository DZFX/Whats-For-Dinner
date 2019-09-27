//
//  PhotosViewController.swift
//  Whats For Dinner
//
//  Created by Isaac Delgado on 9/26/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    private var photosDataSource: GenericCollectionDataSource<Photo, PhotoCollectionViewCell>?
    private var photosDelegate: GenericCollectionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = photosDataSource
    }
    
    func setPhotos(_ photos: [Photo]) {
        photosDataSource = GenericCollectionDataSource<Photo, PhotoCollectionViewCell>(data: photos,
                                                                                       reuseIdentifier: "PhotoCell",
                                                                                       configurationBlock: { (cell, photo) in
                                                                                        cell.configurePhoto(photo)
        })
        photosDelegate = GenericCollectionDelegate(selectionAction: { (_) in })
        photosDelegate?.calculateCellSize = { [weak self] (collection: UICollectionView, indexPath: IndexPath) -> CGSize in
            guard
                let `self` = self,
                let layout = collection.collectionViewLayout as? UICollectionViewFlowLayout,
                let photo = self.photosDataSource?.data[indexPath.row] else { return CGSize(width: 100, height: 100) }
            let width = collection.bounds.size.width - layout.sectionInset.left - layout.sectionInset.right
            return CGSize(width: width, height: (width * CGFloat(photo.height ?? 0)) / CGFloat(photo.width ?? 1))
        }
    }
}
