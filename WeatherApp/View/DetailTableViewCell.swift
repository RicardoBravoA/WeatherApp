//
//  DetailTableViewCell.swift
//  WeatherApp
//
//  Created by Ricardo Bravo on 7/07/21.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    static let identifier = "DetailTableViewCell"
    static let height: CGFloat = 90
    @IBOutlet weak var leftTitleLabel: UILabel!
    @IBOutlet weak var leftValueLable: UILabel!
    @IBOutlet weak var rightTitleLable: UILabel!
    @IBOutlet weak var rightValueLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.leftTitleLabel.adjustsFontSizeToFitWidth = true
        self.rightTitleLable.adjustsFontSizeToFitWidth = true
    }
    
    func setData(using weatherAtRow: DetailWeatherUtil.DetailWeatherAtRow) {
        let (left, right) = weatherAtRow
        self.leftTitleLabel.text = left.title
        self.leftValueLable.text = left.value
        self.rightTitleLable.text = right.title
        self.rightValueLabel.text = right.value
    }
}
