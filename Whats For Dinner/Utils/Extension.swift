//
//  Extension.swift
//  What's For Dinner?
//
//  Created by Isaac Delgado on 9/25/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

import UIKit

extension UIView {
    func showActivityIndicator() {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            let activityIndicator = UIActivityIndicatorView(style: .gray)
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            activityIndicator.center = self.center
            self.addSubview(activityIndicator)
            activityIndicator.hidesWhenStopped = true
            activityIndicator.tag = -404
            activityIndicator.backgroundColor = UIColor.white.withAlphaComponent(0.7)
            activityIndicator.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async { [weak self] in
            guard
                let `self` = self,
                let activityIndicator = self.viewWithTag(-404) as? UIActivityIndicatorView else { return }
            activityIndicator.stopAnimating()
            activityIndicator.removeConstraints(activityIndicator.constraints)
            activityIndicator.removeFromSuperview()
        }
    }
}

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


