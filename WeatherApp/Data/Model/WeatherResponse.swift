//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Ricardo Bravo on 7/07/21.
//

import Foundation

struct WeatherResponse: Codable {
    let cnt: Int
    let list: [ListModel]
    let city: City
}
