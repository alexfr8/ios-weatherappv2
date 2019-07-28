//
//  MainCurrent.swift
//  WeatherAppv2
//
//  Created by Alejandro Fernández Ruiz on 28/07/2019.
//  Copyright © 2019 Alejandro Fernández Ruiz. All rights reserved.
//

import Foundation

struct MainCurrent {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Double
    let humidity : Double
    
}

extension MainCurrent: Decodable {
    
    private enum MainCurrentResponseCodingKeys: String, CodingKey {
        case temp = "temp"
        case temp_min = "temp_min"
        case temp_max = "temp_max"
        case pressure = "pressure"
        case humidity = "humidity"
       
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MainCurrentResponseCodingKeys.self)
        
        temp = try container.decode(Double.self, forKey: .temp)
        temp_min = try container.decode(Double.self, forKey: .temp_min)
        temp_max = try container.decode(Double.self, forKey: .temp_max)
        pressure = try container.decode(Double.self, forKey: .pressure)
        humidity = try container.decode(Double.self, forKey: .humidity)
    }
}
