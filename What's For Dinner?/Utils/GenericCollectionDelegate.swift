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
    
    let selectionAction: Selection
    
    var cellSize: CGSize?
    
    init(selectionAction: @escaping Selection) {
        self.selectionAction = selectionAction
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectionAction(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize ?? CGSize(width: 244, height: 122)
    }
}
