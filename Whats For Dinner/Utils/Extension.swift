//
//  Extension.swift
//  What's For Dinner?
//
//  Created by Isaac Delgado on 9/25/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

import UIKit

extension UIViewController {
    @discardableResult func alertController(title: String?, message: String?, preferredStyle: UIAlertController.Style, actions: [UIAlertAction]) -> UIAlertController {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        if actions.isEmpty {
            alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        } else {
            for action in actions {
                alertController.addAction(action)
            }
        }
        
        return alertController
    }
    
    func presentAlert(_ alertController: UIAlertController, completion: (() -> Void)?) {
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: completion)
        }
        
    }
    
    func displayAlert(message: String) {
        let alert = alertController(title: "Error", message: message, preferredStyle: .alert, actions: [])
        presentAlert(alert, completion: nil)
    }
    
    static func instantiateFromStoryboard() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self))
    }
}


