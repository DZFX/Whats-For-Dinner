//
//  ReviewTableViewCell.swift
//  Whats For Dinner
//
//  Created by Isaac Delgado on 9/26/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var reviewLabel: UILabel!
    @IBOutlet private weak var userLabel: UILabel!
    @IBOutlet private weak var likesLabel: UILabel!

    // MARK: - Config
    func configureReview(_ review: Review) {
        dateLabel.text = review.reviewTimeFriendly ?? "Date unavailable"
        reviewLabel.text = "\"\(review.reviewText ?? "")\""
        
        if let ratingValue = review.rating, let ratingText = review.ratingText {
            ratingLabel.text = "\(ratingText) - \(ratingValue)"
        } else {
            ratingLabel.text = "Rating Unavailable"
        }
        
        if let userName = review.user?.name, let userLevel = review.user?.foodieLevel {
            userLabel.text = "\(userName) - \(userLevel)"
        } else {
            userLabel.text = "Anonymous"
        }
        
        if let likes = review.likes {
            if likes == 1 {
                likesLabel.text = "1 like"
            } else {
                likesLabel.text = "\(likes) likes"
            }
        } else {
            likesLabel.text = "0 likes"
        }
    }
}
