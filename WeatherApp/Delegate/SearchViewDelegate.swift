//
//  SearchViewDelegate.swift
//  WeatherApp
//
//  Created by Ricardo Bravo on 6/07/21.
//

import Foundation

protocol SearchViewDelegate: AnyObject {
    
    func addLocation(name: String, latitude: Double, longitude: Double)
    
}
