//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Ricardo Bravo on 7/07/21.
//

import Foundation

struct WeatherModel: Codable {
    let cnt: Int
    let list: [ListModel]
    let city: City
}
