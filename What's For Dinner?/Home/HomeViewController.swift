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
    
    private let viewModel = HomeViewModel()
    private var tableDataSource: GenericDataSource<Restaurant, RestaurantTableViewCell>?
    private var tableDelegate: GenericTableViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        retrieveRestaurants()
    }

    // MARK: - Config
    private func setupTableView() {
        tableDataSource = GenericDataSource<Restaurant, RestaurantTableViewCell>(data: [],
                                                                                 reuseIdentifier: "RestaurantCell",
                                                                                 configurationBlock: { (cell, restaurant) in
                                                                                    cell.configure(with: restaurant)
        })
        
        tableDelegate = GenericTableViewDelegate(selectionAction: { (indexPath) in
            // move to detail
        })
        tableView.dataSource = tableDataSource
        tableView.delegate = tableDelegate
    }
    
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

}
