//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Ricardo Bravo on 7/07/21.
//

import Foundation
import UIKit

class CurrentWeather: Weather, WeatherDelegate {
    var icon: UIImage {
        return WeatherIconUtil.getImage(named: iconName)
    }
    
    var temperatureText: String {
        return "\(temperature: self.temperature)"
    }
    
    var dateText: String {
        return self.date.getDayOfWeek()
    }
    
    let condition: String
    
    init(iconName: String, temperature: Double, condition: String, date: Date) {
        self.condition = condition
        super.init(iconName: iconName, temperature: temperature, date: date)
    }
}
