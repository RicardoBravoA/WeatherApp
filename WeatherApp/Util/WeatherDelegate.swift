//
//  WeatherDelegate.swift
//  WeatherApp
//
//  Created by Ricardo Bravo on 7/07/21.
//

import Foundation
import UIKit

protocol WeatherDelegate {
    var icon: UIImage { get }
    var temperatureText: String { get }
    var dateText: String { get }
}
