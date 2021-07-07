//
//  ItemViewController.swift
//  WeatherApp
//
//  Created by Ricardo Bravo on 6/07/21.
//

import Foundation
import UIKit

class ItemViewController: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var infoCollectionView: UICollectionView!
    @IBOutlet weak var infoTableView: UITableView!
    
    static let identifier = "ItemViewController"
    var location : Location!
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
    }
    
}
