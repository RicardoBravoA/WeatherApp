//
//  City.swift
//  WeatherApp
//
//  Created by Ricardo Bravo on 7/07/21.
//

import Foundation

struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
}

struct Coord: Codable {
    let lat: Double
    let lon: Double
}
