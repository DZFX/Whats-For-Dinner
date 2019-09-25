//
//  HomeViewController.swift
//  What's For Dinner?
//
//  Created by Isaac Delgado on 9/24/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.getNearbyRestaurants()
    }


}

