//
//  WeatherUtil.swift
//  WeatherApp
//
//  Created by Ricardo Bravo on 7/07/21.
//

import Foundation

class WeatherUtil {
    private let data: WeatherResponse
    private let maxItemCount = 25
    private var utcTimeConverter: DateUtil
    
    init(data: WeatherResponse) {
        self.data = data
        self.utcTimeConverter = DateUtil(timezone: data.city.timezone)
    }
    
    func getCurrentWeather() -> CurrentWeather {
        let weather = data.list[0].weather[0]
        let firstListItem = data.list[0]
        let convertedDate = utcTimeConverter.convertDateFromUTC(string: firstListItem.dtTxt)
        return CurrentWeather(iconName: weather.icon, temperature: firstListItem.main.temp, condition: weather.description, date: convertedDate)
    }
    
    func getHourWeather() -> [HourWeatherUtil] {
        let maxCount = data.list.count > maxItemCount ? maxItemCount : data.list.count
        let weatherList = data.list[0...maxCount]
        return weatherList.map { (list) -> HourWeatherUtil in
            let temp = list.main.temp
            let iconName = list.weather[0].icon
            let convertedDate = utcTimeConverter.convertDateFromUTC(string: list.dtTxt)
            return HourWeatherUtil(iconName: iconName, temperature: temp, date: convertedDate)
        }
    }
    
    func getDailyWeather() -> [DailyWeatherUtil] { // date, icon, temperature-min/max
        var minTemperature = [String: Double]()
        var maxTemperature = [String: Double]()
        var firstDate = [String: Date]()
        var firstIcon = [String: String]()
        for item in data.list {
            let dayOfWeek = utcTimeConverter.convertDateFromUTC(string: item.dtTxt).getDayOfWeek()
            minTemperature.merge([dayOfWeek: item.main.tempMin]) { return $0 > $1 ? $1 : $0 }
            maxTemperature.merge([dayOfWeek: item.main.tempMax]) { return $0 > $1 ? $0 : $1 }
            firstDate.merge([dayOfWeek: utcTimeConverter.convertDateFromUTC(string: item.dtTxt)]) { (first, second) in first }
            firstIcon.merge([dayOfWeek: item.weather[0].icon]) { (first, second) in first }
        }
        var dailyWeatherItems = [DailyWeatherUtil]()
        for key in minTemperature.keys {
            let dailyWeatherItem = DailyWeatherUtil(iconName: firstIcon[key]!, date: firstDate[key]!, maxTemperature: maxTemperature[key]!, minTemperature: minTemperature[key]!)
            dailyWeatherItems.append(dailyWeatherItem)
        }
        return dailyWeatherItems.sorted(by: { (first, second) in
            first.date < second.date
        })
    }
    
    func getDetailWeather() -> DetailWeatherUtil {
        let firstItem = data.list[0].main
        return DetailWeatherUtil(humidity: firstItem.humidity, regularPressure: firstItem.pressure, seaLevelPressure: firstItem.seaLevel, groundLevelPressure: firstItem.grndLevel, wind: data.list[0].wind, clouds: data.list[0].clouds)
    }
}
