//
//  DetailWeatherUtil.swift
//  WeatherApp
//
//  Created by Ricardo Bravo on 7/07/21.
//

import Foundation

class DetailWeatherUtil {
    typealias DetailWeatherAtRow = (TitleValuePair, TitleValuePair)
    typealias TitleValuePair = (title: String, value: String)
    
    private struct Constants {
        static let humidity = "Humidity"
        static let pressure = "Pressure"
        static let seaLevelPressure = "Sea level pressure"
        static let groundLevelPressure = "Ground level pressure"
        static let wind = "Wind"
        static let clouds = "Clouds"
    }
    
    var titleValuPairs = [TitleValuePair]()
    var totalRow: Int {
        return self.titleValuPairs.count / 2
    }
    
    init(humidity: Int, regularPressure: Double, seaLevelPressure: Double, groundLevelPressure: Double, wind: Wind, clouds: Clouds) {
        titleValuPairs.append((Constants.humidity, "\(humidity: humidity)"))
        titleValuPairs.append((Constants.pressure, "\(pressure: regularPressure)"))
        titleValuPairs.append((Constants.seaLevelPressure, "\(pressure: seaLevelPressure)"))
        titleValuPairs.append((Constants.groundLevelPressure, "\(pressure: groundLevelPressure)"))
        titleValuPairs.append((Constants.wind, "\(wind: wind)"))
        titleValuPairs.append((Constants.clouds, "\(clouds: clouds)"))
    }
    
    func getDetailWeather(at rowIndex: Int) -> DetailWeatherAtRow {
        let index = rowIndex * 2
        let leftItem = titleValuPairs[index]
        let rightItem = titleValuPairs[index + 1]
        return (leftItem, rightItem)
    }
}
