//
//  AddLocationDelegate.swift
//  WeatherApp
//
//  Created by Ricardo Bravo on 6/07/21.
//

import Foundation

protocol AddLocationDelegate: AnyObject {
    func userSelectLocation(at index: Int)
    func addLocation(location: Location)
    func userDeleteLocation(at index: Int)
}
