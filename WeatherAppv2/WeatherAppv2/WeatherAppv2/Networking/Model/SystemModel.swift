//
//  SystemModel.swift
//  WeatherAppv2
//
//  Created by Alejandro Fernández Ruiz on 28/07/2019.
//  Copyright © 2019 Alejandro Fernández Ruiz. All rights reserved.
//

import Foundation


struct SystemModel {
   
 //   let type: Int?
 //   let id : Int
    let message : Double
    let country : String
    let sunrise : Int
    let sunset : Int
    
}


extension SystemModel: Decodable {
    
    private enum SystemModelResponseCodingKeys: String, CodingKey {
       // case type = "type"
       // case id = "id"
        case message = "message"
        case country = "country"
        case sunrise = "sunrise"
        case sunset = "sunset"
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SystemModelResponseCodingKeys.self)
        
    //    type  = try container.decode(Int.self, forKey: .type)
    //    id = try container.decode(Int.self, forKey: .id)
        message = try container.decode(Double.self, forKey: .message)
        country = try container.decode(String.self, forKey: .country)
        sunrise = try container.decode(Int.self, forKey: .sunrise)
        sunset = try container.decode(Int.self, forKey: .sunset)
    }
}
