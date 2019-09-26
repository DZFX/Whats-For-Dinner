//
//  RestaurantDetailViewController.swift
//  What's For Dinner?
//
//  Created by Isaac Delgado on 9/26/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private var detailHeader: RestaurantDetailHeader!
    private var viewModel: RestaurantDetailViewModel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }
    
    func setupViewModel(model: Restaurant) {
        viewModel = RestaurantDetailViewModel(restaurant: model)
    }
    
    private func setupTable() {
        tableView.tableHeaderView = detailHeader
        detailHeader.setImageURLString(urlString: viewModel.featuredPhoto)
        detailHeader.name = viewModel.restaurantName
        detailHeader.cuisine = viewModel.cuisine
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension RestaurantDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 1
        case 2:
            return 2
        default:
            return viewModel.numberOfHighlights
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell") ?? UITableViewCell(style: .default, reuseIdentifier: "DetailCell")
        
        switch indexPath.section {
        case 0: // Hours & Contact
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = viewModel.hours
            case 1:
                cell.textLabel?.text = viewModel.phoneNumbers
            default:
                cell.textLabel?.text = viewModel.address
            }
        case 1: // Rating
            cell.textLabel?.text = viewModel.ratingStatement
        case 2: // Reviews & Media
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = RestaurantDetailViewModel.viewReviews
            default:
                cell.textLabel?.text = RestaurantDetailViewModel.viewPhotos
            }
        default: // Other Info
            cell.textLabel?.text = viewModel.highlight(row: indexPath.row)
            cell.accessoryType = .checkmark
        }
        
        
        return cell
    }
    
    
}

extension RestaurantDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.title(from: section)
    }
}
