//
//  ReviewsViewController.swift
//  Whats For Dinner
//
//  Created by Isaac Delgado on 9/26/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

import UIKit

class ReviewsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    private var reviewsDataSource: GenericTableDataSource<Review, ReviewTableViewCell>?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = reviewsDataSource
    }

    func setReviews(_ reviews: [Review]) {
        reviewsDataSource = GenericTableDataSource<Review, ReviewTableViewCell>(data: reviews,
                                                                                reuseIdentifier: "ReviewCell",
                                                                                configurationBlock: { (cell, review) in
                                                                                    cell.configureReview(review)
        })
    }
}
