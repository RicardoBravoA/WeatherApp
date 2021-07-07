//
//  EndPoint.swift
//  WeatherApp
//
//  Created by Ricardo Bravo on 7/07/21.
//

import Foundation

enum EndPoint {
    static let baseUrl = "https://api.openweathermap.org/data/2.5/forecast"
    static let appID = "890b83aba8fa4d8fd692ca270ce8cc82"
    
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
