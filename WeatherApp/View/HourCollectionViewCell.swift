//
//  HourCollectionViewCell.swift
//  WeatherApp
//
//  Created by Ricardo Bravo on 7/07/21.
//

import UIKit

class HourCollectionViewCell: UICollectionViewCell {
    static let identifier = "HourCollectionViewCell"
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    func setData(from weatherItem : WeatherDelegate) {
        self.temperatureLabel.text = weatherItem.temperatureText
        self.hourLabel.text = weatherItem.dateText
        self.weatherIconImageView.image = weatherItem.icon
    }
}
