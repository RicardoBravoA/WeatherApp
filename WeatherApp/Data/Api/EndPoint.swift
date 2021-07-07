//
//  EndPoint.swift
//  WeatherApp
//
//  Created by Ricardo Bravo on 7/07/21.
//

import Foundation

enum EndPoint {
    static let baseUrl = "https://api.openweathermap.org/data/2.5/forecast"
    static let appID = "166385d107df2e4cd08f6f7a2973878a"
    
    case weather(Double, Double)
    
    var value: String {
        switch self {
        case .weather(let latitude, let longitude):
            return EndPoint.baseUrl + "?lat=\(latitude)&lon=\(longitude)&appid=\(EndPoint.appID)"
        }
    }
    
    var url: URL {
        return URL(string: value)!
    }
}
