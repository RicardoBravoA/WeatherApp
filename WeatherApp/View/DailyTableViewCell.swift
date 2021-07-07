//
//  DailyTableViewCell.swift
//  WeatherApp
//
//  Created by Ricardo Bravo on 7/07/21.
//

import Foundation
import UIKit

class DailyTableViewCell: UITableViewCell {
    static let identifier = "DailyTableViewCell"
    static let height: CGFloat = 44

    @IBOutlet weak var dayOfWeekLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var maxMinTemperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.backgroundColor = .clear
    }
    
    func setData(from weatherItem: WeatherDelegate) {
        self.weatherIconImageView.image = weatherItem.icon
        self.dayOfWeekLabel.text = weatherItem.dateText
        self.maxMinTemperatureLabel.text = weatherItem.temperatureText
    }

}
