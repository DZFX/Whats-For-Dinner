//
//  GenericCollectionDataSource.swift
//  What's For Dinner?
//
//  Created by Isaac Delgado on 9/25/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

import UIKit

class GenericCollectionDataSource<T, C: UICollectionViewCell>: NSObject, UICollectionViewDataSource {
    typealias CellConfiguration = ((C, T) -> Void)
    
    var data: [T]
    let reuseIdentifier: String
    let configurationBlock: CellConfiguration
    
    init(data: [T], reuseIdentifier: String, configurationBlock: @escaping CellConfiguration) {
        self.data = data
        self.reuseIdentifier = reuseIdentifier
        self.configurationBlock = configurationBlock
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? C else {
            return UICollectionViewCell()
        }
        
        let item = data[indexPath.item]
        configurationBlock(cell, item)
        
        return cell
    }
}


