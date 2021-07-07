//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Ricardo Bravo on 6/07/21.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var infoCollectionView: UICollectionView!
    @IBOutlet weak var infoTableView: UITableView!
    
    static let identifier = "ItemViewController"
    var location : Location!
    
    var currentWeather: CurrentWeather?
    var dailyWeather: [DailyWeatherUtil]?
    var hourWeather: [HourWeatherUtil]?
    var detailWeather: DetailWeatherUtil?
    var temperature: TemperatureUnit.Unit?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("z- Location \(location)")
        setUpInfoTableView()
        weather()
    }
    
    private func weather() {
        guard let location = location else {
            print("Not location")
            return
        }
        
        ApiClient.weather(latitude: location.latitude, longitude: location.longitude) { response, error in
            
            guard let weather = response, error == nil else {
                print("Error \(error)")
                return
            }
            self.parseData(data: weather)
        }
    }
    
    private func parseData(data: WeatherResponse) {
        let weatherUtil = WeatherUtil(data: data)
        currentWeather = weatherUtil.getCurrentWeather()
        hourWeather = weatherUtil.getHourWeather()
        dailyWeather = weatherUtil.getDailyWeather()
        detailWeather = weatherUtil.getDetailWeather()
        
        print("z- CurrentWeather \(currentWeather)")
        print("z- hourWeather \(hourWeather)")
        print("z- dailyWeather \(dailyWeather)")
        print("z- detailWeather \(detailWeather)")
    }
    
    private func setUpInfoTableView() {
        
    }
    
}
