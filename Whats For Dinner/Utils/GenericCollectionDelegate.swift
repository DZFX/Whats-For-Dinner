//
//  GenericCollectionDelegate.swift
//  What's For Dinner?
//
//  Created by Isaac Delgado on 9/25/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

import UIKit

class GenericCollectionDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    typealias Selection = ((IndexPath) -> Void)
    typealias CellSize = ((UICollectionView, IndexPath) -> CGSize)
    
    let selectionAction: Selection
    
    var cellSize: CGSize?
    var calculateCellSize: CellSize?
    
    init(selectionAction: @escaping Selection) {
        self.selectionAction = selectionAction
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectionAction(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let cellSize = calculateCellSize {
            return cellSize(collectionView, indexPath)
        }else if let size = self.cellSize {
            return size
        } else if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            let width = ((collectionView.bounds.size.width - layout.sectionInset.left - layout.sectionInset.right) / 2) - layout.minimumInteritemSpacing
            return CGSize(width: width, height: width * 0.7)
        } else {
            return CGSize(width: 100, height: 100)
        }
    }
}
