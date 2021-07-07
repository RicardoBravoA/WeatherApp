//
//  Clouds.swift
//  WeatherApp
//
//  Created by Ricardo Bravo on 7/07/21.
//

import Foundation

struct Clouds: Codable {
    let all: Int
    
    var text: String {
        return "\(all)"
    }
}
