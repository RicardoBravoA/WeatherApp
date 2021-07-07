//
//  TemperatureUnit.swift
//  WeatherApp
//
//  Created by Ricardo Bravo on 7/07/21.
//

import Foundation

class TemperatureUnit {
    enum Unit {
        case celcius, fahrenheit
        
        init(bool: Bool) {
            self = bool ? .celcius : .fahrenheit
        }
    }
    static let shared = TemperatureUnit()
    
    var unit: Unit
    
    init() {
        self.unit = Unit(bool: true)
    }
    
    init(bool: Bool) {
        self.unit = Unit(bool: bool)
    }
    
    func setUnit(with newValue: Bool) {
        self.unit = Unit(bool: newValue)
    }
    
    var boolValue: Bool {
        return self.unit == .celcius ? true : false
    }
}
