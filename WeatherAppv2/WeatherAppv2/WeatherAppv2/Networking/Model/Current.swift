//
//  Current.swift
//  WeatherAppv2
//
//  Created by Alejandro Fernández Ruiz on 28/07/2019.
//  Copyright © 2019 Alejandro Fernández Ruiz. All rights reserved.
//

import Foundation


struct Current {
    let coord: Coordinate
    let weather : [Weather]
    let clouds : Clouds
    let main : MainCurrent
    let wind : Wind
    let timezone : Int
    let id :Int
    let name: String
    let cod: Int
    let sys: SystemModel
    let dt: Int
    let base: String
}

extension Current: Decodable {
    
    private enum CurrentResponseCodingKeys: String, CodingKey {
        case coord = "coord"
        case weather = "weather"
        case clouds = "clouds"
        case main = "main"
        case wind = "wind"
        case timezone = "timezone"
        case id = "id"
        case name = "name"
        case cod = "cod"
        case sys = "sys"
        case dt = "dt"
        case base = "base"
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CurrentResponseCodingKeys.self)
        
        coord  = try container.decode(Coordinate.self, forKey: .coord)
        weather = try container.decode([Weather].self, forKey: .weather)
        clouds = try container.decode(Clouds.self, forKey: .clouds)
        main = try container.decode(MainCurrent.self, forKey: .main)
        wind = try container.decode(Wind.self, forKey: .wind)
         timezone = try container.decode(Int.self, forKey: .timezone)
         id = try container.decode(Int.self, forKey: .id)
         name = try container.decode(String.self, forKey: .name)
         cod = try container.decode(Int.self, forKey: .cod)
         sys = try container.decode(SystemModel.self, forKey: .sys)
         dt = try container.decode(Int.self, forKey: .dt)
         base = try container.decode(String.self, forKey: .base)
        
    }
}
