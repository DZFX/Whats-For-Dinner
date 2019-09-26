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
}

extension UIImageView {
    func downloadImage(from urlString: String, placeholder: UIImage? = UIImage(named: "Placeholder")) {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.tag = -404
        addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicator.setNeedsLayout()
        activityIndicator.startAnimating()
        image = placeholder
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                if let activityIndicator = self.viewWithTag(-404) as? UIActivityIndicatorView {
                    activityIndicator.stopAnimating()
                    activityIndicator.removeConstraints(activityIndicator.constraints)
                    activityIndicator.removeFromSuperview()
                }
            }
            
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
}
