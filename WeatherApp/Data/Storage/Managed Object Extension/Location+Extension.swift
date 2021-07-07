//
//  Managed Object Extension.swift
//  WeatherApp
//
//  Created by Ricardo Bravo on 6/07/21.
//

import Foundation

extension Location {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        created = Date()
    }
    
}
