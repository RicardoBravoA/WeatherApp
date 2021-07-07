//
//  DetailViewController+TableView.swift
//  WeatherApp
//
//  Created by Ricardo Bravo on 7/07/21.
//

import Foundation
import UIKit

extension DetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return DailyTableViewSection.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = DailyTableViewSection(sectionIndex: section) else {
            return 0
        }
        switch section {
        case .daily:
            return dailyWeather?.count ?? 0
        case .detail:
            return detailWeather?.totalRow ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = DailyTableViewSection(sectionIndex: indexPath.section) else {
            return DailyTableViewCell()
        }
        switch section {
        case .daily:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyTableViewCell.identifier, for: indexPath) as? DailyTableViewCell,
                let weatherItem = viewModel?.dailyWeatherItems.value?[indexPath.row] else {
                return DailyTableViewCell()
            }
            cell.setWeatherData(from: weatherItem)
            return cell
        case .detail:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as? DetailTableViewCell,
                let weatherPair = viewModel?.detailWeather.value?.getDetailWeather(at: indexPath.row) else {
                return DetailTableViewCell()
            }
            cell.setWeatherData(using: weatherPair)
            return cell
        }
    }
}

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = DailyTableViewSection(sectionIndex: indexPath.section) else {
            return DailyTableViewSection.defaultCellHeight
        }
        return section.cellHeight
    }
}
