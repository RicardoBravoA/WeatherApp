//
//  UIViewController+Extensions.swift
//  WeatherApp
//
//  Created by Ricardo Bravo on 7/07/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlertController(message: String) {
        let alertController = UIAlertController(title: "WeatherApp", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
}
