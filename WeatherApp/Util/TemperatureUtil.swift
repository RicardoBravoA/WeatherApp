//
//  TemperatureUtil.swift
//  WeatherApp
//
//  Created by Ricardo Bravo on 7/07/21.
//

import Foundation

class TemperatureUtil {
    static let celciusGap = 273.15
    let kelvinValue: Double
    
    init(kelvin: Double) {
        self.kelvinValue = kelvin
    }
    
    var text: String {
        return TemperatureUnit.shared.boolValue ? "\(toCelcius)" : "\(toFahrenheit)"
    }
    
    var toCelcius: Int {
        return Int(kelvinValue - TemperatureUtil.celciusGap)
    }
    
    var toFahrenheit: Int {
        let convertedValue = (kelvinValue - 273.15) * 9/5 + 32
        return Int(convertedValue)
    }
}
