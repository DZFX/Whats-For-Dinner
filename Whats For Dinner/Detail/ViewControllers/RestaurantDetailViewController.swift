//
//  RestaurantDetailViewController.swift
//  What's For Dinner?
//
//  Created by Isaac Delgado on 9/26/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private var detailHeader: RestaurantDetailHeader!
    @IBOutlet private var mapButton: UIBarButtonItem!
    
    // MARK: - Properties
    private var viewModel: RestaurantDetailViewModel!
    var canDisplayMap = true
    
    // MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        if canDisplayMap { navigationItem.rightBarButtonItem = mapButton }
        title = viewModel.restaurantName
    }
    
    // MARK: - Config
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
    
    // MARK: - User actions
    private func openReviews(_ reviews: [Review]) {
        guard let reviewsVC = ReviewsViewController.instantiateFromStoryboard() as? ReviewsViewController else { return }
        reviewsVC.setReviews(reviews)
        reviewsVC.navigationItem.title = "Reviews"
        reviewsVC.navigationItem.prompt = viewModel.restaurantName
        navigationController?.pushViewController(reviewsVC, animated: true)
    }
    
    private func openPhotos(_ photos: [Photo]) {
        guard let photosVC = PhotosViewController.instantiateFromStoryboard() as? PhotosViewController else { return }
        photosVC.setPhotos(photos)
        photosVC.navigationItem.title = "Photos"
        photosVC.navigationItem.prompt = viewModel.restaurantName
        navigationController?.pushViewController(photosVC, animated: true)
    }
    
    private func openMap(with restaurants: [Restaurant]) {
        guard let mapVC = MapViewController.instantiateFromStoryboard() as? MapViewController else { return }
        mapVC.configure(restaurants: restaurants)
        mapVC.canDisplayDetail = false
        mapVC.title = title
        navigationController?.pushViewController(mapVC, animated: true)
    }
    
    @IBAction func tappedMapButton() {
        openMap(with: [viewModel.restaurant])
    }
}

// MARK: - Table view data source
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
        cell.accessoryType = .none
        
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
                cell.textLabel?.text = viewModel.viewReviewsCounter
                if viewModel.hasReviews { cell.accessoryType = .disclosureIndicator }
            default:
                cell.textLabel?.text = viewModel.viewPhotosCounter
                if viewModel.hasPhotos { cell.accessoryType = .disclosureIndicator }
            }
        default: // Other Info
            cell.textLabel?.text = viewModel.highlight(row: indexPath.row)
            cell.accessoryType = .checkmark
        }

        return cell
    }
}

// MARK: - Table view delegate
extension RestaurantDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.title(from: section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 2 {
            if indexPath.row == 0 {
                // Reviews
                if viewModel.hasReviews {
                    openReviews(viewModel.reviews)
                }
            } else {
                // Media
                if viewModel.hasPhotos {
                    openPhotos(viewModel.photos)
                }
            }
        }
    }
}
