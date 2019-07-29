//
//  UtilsCoord.swift
//  WeatherAppv2
//
//  Created by Alejandro Fernández Ruiz on 29/07/2019.
//  Copyright © 2019 Alejandro Fernández Ruiz. All rights reserved.
//

import Foundation
import MapKit

class UtilsCoord {
    
    static let shared = UtilsCoord()
    let earth : Double = 6371
    
     func coordinates(startingCoordinates: CLLocationCoordinate2D, atDistance: Double, atAngle: Double) -> CLLocationCoordinate2D {
        let distanceRadians = atDistance / earth
        let bearingRadians = self.degreesToRadians(x: atAngle)
        let fromLatRadians = self.degreesToRadians(x: startingCoordinates.latitude)
        let fromLonRadians = self.degreesToRadians(x: startingCoordinates.longitude)
        
        let toLatRadians = asin(sin(fromLatRadians) * cos(distanceRadians) + cos(fromLatRadians) * sin(distanceRadians) * cos(bearingRadians))
        var toLonRadians = fromLonRadians + atan2(sin(bearingRadians) * sin(distanceRadians) * cos(fromLatRadians), cos(distanceRadians) - sin(fromLatRadians) * sin(toLatRadians));
        
        toLonRadians = fmod((toLonRadians + 3 * .pi), (2 * .pi)) - .pi
        
        let lat = self.radiansToDegrees(x: toLatRadians)
        let lon = self.radiansToDegrees(x: toLonRadians)
        
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
    
    private func degreesToRadians(x: Double) -> Double {
        return .pi * x / 180.0
    }
    
    private func radiansToDegrees(x: Double) -> Double {
        return x * 180.0 / .pi
    }
}
