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
    @IBOutlet weak var todayTextLabel: UILabel!
    
    static let identifier = "ItemViewController"
    var location : Location!
    
    var currentWeather: CurrentWeather?
    var dailyWeather: [DailyWeatherUtil]?
    var hourWeather: [HourWeatherUtil]?
    var detailWeather: DetailWeatherUtil?
    var temperature: TemperatureUnit.Unit?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    private func getData() {
        guard let location = location else {
            print("Not location")
            return
        }
        
        ApiClient.weather(latitude: location.latitude, longitude: location.longitude) { response, error in
            
            guard let weather = response, error == nil else {
                print("Error \(error?.localizedDescription)")
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
        
        todayTextLabel.text = "Today: "
        cityLabel.text = location.name
        weatherDescription.text = currentWeather?.condition
        temperatureLabel.text = currentWeather?.temperatureText
        todayLabel.text = currentWeather?.dateText
        
        infoTableView.reloadData()
        infoCollectionView.reloadData()
        
    }
    
}
