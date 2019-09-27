//
//  GenericTableDelegate.swift
//  What's For Dinner?
//
//  Created by Isaac Delgado on 9/25/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

import UIKit

class GenericTableViewDelegate: NSObject, UITableViewDelegate {
    
    typealias Selection = ((IndexPath) -> Void)
    typealias HeaderViewAction = ((Int) -> UIView?)
    
    let selectionAction: Selection
    
    var headerView: HeaderViewAction?
    var cellHeight: CGFloat?
    
    init(selectionAction: @escaping Selection) {
        self.selectionAction = selectionAction
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectionAction(indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight ?? tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.headerView?(section) ?? UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
}
