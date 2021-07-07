//
//  ListModel.swift
//  WeatherApp
//
//  Created by Ricardo Bravo on 7/07/21.
//

import Foundation

struct ListModel: Codable {
    let dt: Int
    let main: MainModel
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let dtTxt: String
    let rain: Rain?
    let snow: Snow?
    
    enum CodingKeys: String, CodingKey {
        case dt
        case main
        case weather
        case clouds
        case wind
        case dtTxt = "dt_txt"
        case rain
        case snow
    }
}
