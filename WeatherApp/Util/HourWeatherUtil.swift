//
//  HourWeatherUtil.swift
//  WeatherApp
//
//  Created by Ricardo Bravo on 7/07/21.
//

import Foundation
import UIKit

class HourWeatherUtil: Weather, WeatherDelegate {
    
    var icon: UIImage {
        return WeatherIconUtil.getImage(named: iconName)
    }
    
    var temperatureText: String {
        return "\(temperature: self.temperature)"
    }
    
    var dateText: String {
        return self.date.getHour()
    }
}
