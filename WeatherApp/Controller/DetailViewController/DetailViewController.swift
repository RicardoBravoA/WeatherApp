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
    @IBOutlet weak var activityMonitor: UIActivityIndicatorView!
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
            return
        }
        
        activityMonitor.startAnimating()
        
        ApiClient.weather(latitude: location.latitude, longitude: location.longitude) { response, error in
            
            guard let weather = response, error == nil else {
                self.activityMonitor.stopAnimating()
                self.showAlertController(message: error?.localizedDescription ?? "")
                return
            }
            self.parseData(data: weather)
        }
    }
    
    private func parseData(data: WeatherResponse) {
        DispatchQueue.main.async {
            let weatherUtil = WeatherUtil(data: data)
            self.currentWeather = weatherUtil.getCurrentWeather()
            self.hourWeather = weatherUtil.getHourWeather()
            self.dailyWeather = weatherUtil.getDailyWeather()
            self.detailWeather = weatherUtil.getDetailWeather()
            
            self.todayTextLabel.text = "Today: "
            self.cityLabel.text = self.location.name
            self.weatherDescription.text = self.currentWeather?.condition
            self.temperatureLabel.text = self.currentWeather?.temperatureText
            self.todayLabel.text = self.currentWeather?.dateText
            
            self.infoTableView.reloadData()
            self.infoCollectionView.reloadData()
            
            self.activityMonitor.stopAnimating()
        }
    }
    
    func showAlertController(message: String) {
        let alertController = UIAlertController(title: "WeatherApp", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
}
