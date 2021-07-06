//
//  Location.swift
//  WeatherApp
//
//  Created by Ricardo Bravo on 6/07/21.
//

import Foundation

struct Location {
    let name: String
    let latitude: Double
    let longitude: Double
    
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
}
