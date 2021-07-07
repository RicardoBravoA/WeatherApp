//
//  DailyWeatherUtil.swift
//  WeatherApp
//
//  Created by Ricardo Bravo on 7/07/21.
//

import Foundation
import UIKit

class DailyWeatherUtil: Weather, WeatherDelegate {
    var icon: UIImage {
        return WeatherIconUtil.getImage(named: iconName)
    }
    
    var temperatureText: String {
        let max = "\(temperature: maxTemperature)"
        let min = "\(temperature: minTemperature)"
        return "\(max)  \(min)"
    }
    
    var dateText: String {
        return self.date.getDayOfWeek()
    }

    private let maxTemperature: TemperatureUtil
    private let minTemperature: TemperatureUtil
    
    init(iconName: String, date: Date, maxTemperature: Double, minTemperature: Double) {
        self.maxTemperature = TemperatureUtil(kelvin: maxTemperature)
        self.minTemperature = TemperatureUtil(kelvin: minTemperature)
        super.init(iconName: iconName, temperature: minTemperature, date: date)
    }
}
