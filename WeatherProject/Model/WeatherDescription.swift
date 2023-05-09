//
//  WeatherDescription.swift
//  WeatherProject
//
//  Created by Eyüphan Akkaya on 8.05.2023.
//

import Foundation
import UIKit

struct WeatherDescription: Codable {
    var iconName: String
    var description: String
    
    var icon: UIImage? {
        return UIImage(named: iconName)
        
    }
    enum CodingKeys:String,CodingKey {
        case iconName = "icon"
        case description = "description"
    }
    
}
