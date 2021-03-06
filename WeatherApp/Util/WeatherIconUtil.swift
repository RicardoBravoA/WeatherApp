//
//  WeatherIconUtil.swift
//  WeatherApp
//
//  Created by Ricardo Bravo on 7/07/21.
//

import Foundation
import UIKit

class WeatherIconUtil {
    
    static var cachedIcon = NSCache<NSString, UIImage>()
    
    static func getImage(named name: String) -> UIImage {
        let convertedName = NSString(string: name)
        guard let wantedImage = cachedIcon.object(forKey: convertedName) else {
            let newImage = UIImage(named: name) ?? UIImage()
            cachedIcon.setObject(newImage, forKey: convertedName)
            return newImage
        }
        return wantedImage
    }
}
