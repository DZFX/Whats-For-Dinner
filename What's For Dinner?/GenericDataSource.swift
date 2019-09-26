//
//  GenericDataSource.swift
//  What's For Dinner?
//
//  Created by Isaac Delgado on 9/25/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

import UIKit

class GenericDataSource<T, C: UITableViewCell>: NSObject, UITableViewDataSource {
    typealias CellConfiguration = ((C, T) -> Void)
    
    var data: [T]
    let reuseIdentifier: String
    let configurationBlock: CellConfiguration
    
    init(data: [T], reuseIdentifier: String, configurationBlock: @escaping CellConfiguration) {
        self.data = data
        self.reuseIdentifier = reuseIdentifier
        self.configurationBlock = configurationBlock
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? C else {
            return UITableViewCell()
        }
        let item = data[indexPath.row]
        configurationBlock(cell, item)
        return cell
    }
}
