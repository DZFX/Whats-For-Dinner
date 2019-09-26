//
//  CategoriesViewController.swift
//  What's For Dinner?
//
//  Created by Isaac Delgado on 9/24/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private var dataSource: GenericCollectionDataSource<Category, CategoryCollectionViewCell>?
    private var delegate: GenericCollectionDelegate?
    
    private let viewModel = CategoriesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        retrieveCategories()
    }

    // MARK: - Config
    private func setupCollectionView() {
        dataSource = GenericCollectionDataSource<Category, CategoryCollectionViewCell>(data: [],
                                                                                       reuseIdentifier: "CategoryCell",
                                                                                       configurationBlock: { (cell, category) in
                                                                                        cell.configure(with: category)
        })
        delegate = GenericCollectionDelegate(selectionAction: { (indexPath) in
            // action
        })
        
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
    }

    // MARK: - Network calls
    private func retrieveCategories() {
        viewModel.getCategories { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case let .failure(error):
                self.displayAlert(message: error.localizedDescription)
            case let .success(categories):
                self.dataSource?.data = categories
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
}

