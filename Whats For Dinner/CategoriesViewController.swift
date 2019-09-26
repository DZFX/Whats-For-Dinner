//
//  CategoriesViewController.swift
//  What's For Dinner?
//
//  Created by Isaac Delgado on 9/24/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    private var dataSource: GenericCollectionDataSource<Category, CategoryCollectionViewCell>?
    private var delegate: GenericCollectionDelegate?
    
    private let viewModel = CategoriesViewModel()
    
    // MARK: - Life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
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
        delegate = GenericCollectionDelegate(selectionAction: { [weak self] (indexPath) in
            guard let `self` = self,
                let category = self.dataSource?.data[indexPath.row] else { return }
            self.openCategory(category)
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
    
    // MARK: - User actions
    private func openCategory(_ category: Category) {
        guard let restaurantsVC = RestaurantsViewController.instantiateFromStoryboard() as? RestaurantsViewController else { return }
        restaurantsVC.setCategory(category)
        navigationController?.pushViewController(restaurantsVC, animated: true)
    }
}

