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
    
    private let isHeaderHiddenOnEmpty: Bool
    var headerViewHeight = CGFloat(44.0)
    let selectionAction: Selection
    
    var headerView: HeaderViewAction?
    var cellHeight: CGFloat?
    
    init(selectionAction: @escaping Selection, headerHiddenOnEmpty: Bool = false) {
        self.selectionAction = selectionAction
        self.isHeaderHiddenOnEmpty = headerHiddenOnEmpty
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectionAction(indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.headerView?(section) ?? UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight ?? tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.isHeaderHiddenOnEmpty {
            if let count = tableView.dataSource?.tableView(tableView, numberOfRowsInSection: section),
                count > 0,
                self.headerView?(section) != nil {
                return headerViewHeight
            }
        } else if self.headerView?(section) != nil {
            return headerViewHeight
        }
        return 0.0
    }
}
