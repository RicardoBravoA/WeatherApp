//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Ricardo Bravo on 7/07/21.
//

import Foundation

struct WeatherModel: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
