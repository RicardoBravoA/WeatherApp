//
//  Weather.swift
//  WeatherApp
//
//  Created by Ricardo Bravo on 7/07/21.
//

import Foundation

class Weather {
    let iconName: String
    let temperature: TemperatureUtil
    let date: Date
    
    init(iconName: String, temperature: Double, date: Date) {
        self.iconName = iconName
        self.temperature = TemperatureUtil(kelvin: temperature)
        self.date = date
    }
}
