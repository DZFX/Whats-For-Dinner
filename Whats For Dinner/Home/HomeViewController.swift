//
//  HomeViewController.swift
//  What's For Dinner?
//
//  Created by Isaac Delgado on 9/24/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let viewModel = HomeViewModel()
    private var tableDataSource: GenericTableDataSource<Restaurant, RestaurantTableViewCell>?
    private var tableDelegate: GenericTableViewDelegate?
    
    private var collectionDataSource: GenericCollectionDataSource<Restaurant, TrendingCollectionViewCell>?
    private var collectionDelegate: GenericCollectionDelegate?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupCollectionView()
        retrieveRestaurants()
        retrieveTrending()
    }

    // MARK: - Config
    private func setupTableView() {
        tableDataSource = GenericTableDataSource<Restaurant, RestaurantTableViewCell>(data: [],
                                                                                 reuseIdentifier: "RestaurantCell",
                                                                                 configurationBlock: { (cell, restaurant) in
                                                                                    cell.configure(with: restaurant)
        })
        
        tableDelegate = GenericTableViewDelegate(selectionAction: { [weak self] (indexPath) in
            guard let `self` = self,
                let restaurant = self.tableDataSource?.data[indexPath.row] else { return }
            self.openDetail(from: restaurant)
        })
        
        tableView.dataSource = tableDataSource
        tableView.delegate = tableDelegate
    }
    
    private func setupCollectionView() {
        collectionDataSource = GenericCollectionDataSource<Restaurant, TrendingCollectionViewCell>(data: [],
                                                                                                   reuseIdentifier: "TrendingCell",
                                                                                                   configurationBlock: { (cell, restaurant) in
                                                                                                    cell.configure(with: restaurant)
        })
        
        collectionDelegate = GenericCollectionDelegate(selectionAction: { [weak self] (indexPath) in
            guard let `self` = self,
                let restaurant = self.collectionDataSource?.data[indexPath.row] else { return }
            self.openDetail(from: restaurant)
        })
        collectionDelegate?.cellSize = CGSize(width: 244, height: 122)
        
        collectionView.dataSource = collectionDataSource
        collectionView.delegate = collectionDelegate
    }
    
    // MARK: - Network actions
    private func retrieveRestaurants() {
        viewModel.getNearbyRestaurants { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case let .failure(error):
                self.displayAlert(message: error.localizedDescription)
            case let .success(restaurants):
                self.tableDataSource?.data = restaurants
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    private func retrieveTrending() {
        viewModel.getTrendingRestaurants { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case let .failure(error):
                self.displayAlert(message: error.localizedDescription)
            case let .success(restaurants):
                self.collectionDataSource?.data = restaurants
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    // MARK: - User actions
    private func openDetail(from restaurant: Restaurant) {
        guard let detailVC = RestaurantDetailViewController.instantiateFromStoryboard() as? RestaurantDetailViewController else { return }
        detailVC.setupViewModel(model: restaurant)
        navigationController?.pushViewController(detailVC, animated: true)
    }

}
