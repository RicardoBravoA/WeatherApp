//
//  Wind.swift
//  WeatherApp
//
//  Created by Ricardo Bravo on 7/07/21.
//

import Foundation

struct Wind: Codable {
    let speed: Double
    let deg: Double
    
    var direction: WindDirection {
        return WindDirection.init(degree: self.deg)
    }
}
