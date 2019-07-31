//
//  OpenWheatherEndPoint.swift
//  WeatherApp
//
//  Created by Alejandro Fernández Ruiz on 6/10/18.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation
enum NetworkEnvironment {
    case apiForescast
    case historyData
}


public enum OpenWeatherEndPoint {
    
    
    case forecastSevendDaysByCityName(city:String)
    case forecastSevendDaysByCoord(lat:Double, long: Double)
    case currentWeatherByCityName(city: String)
    case currentWeatherByZip(zip: String)
    case currentWeatherByCoords(lat: Double, long: Double)
    
    case historicWeatherByCoords(lat: Double, long: Double)
}


extension OpenWeatherEndPoint: EndPointType {
    
    
    
    var environmentBaseURL : String {
       
        switch OpenWeatherManager.appEnvironment {

       
        case .apiForescast:
            return "https://api.openweathermap.org"
        case .historyData:
            return "http://history.openweathermap.org"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
            
        case .forecastSevendDaysByCityName( _):
            return "/data/2.5/forecast"
                //q=London&mode=xml&units=metric&cnt=7
        case .forecastSevendDaysByCoord:
            return "/data/2.5/forecast"
            ///data/2.5/forecast/daily?lat={lat}&lon={lon}&cnt={cnt}
        case .currentWeatherByCityName( _):
            return "/data/2.5/weather"
        case .currentWeatherByZip( _):
             return "/data/2.5/weather"
        case .currentWeatherByCoords:
            return "/data/2.5/weather"
        case .historicWeatherByCoords(_, _):
            return "/data/2.5/history/city"
        }
    }
    
    
    var httpMethod: HTTPMethod {
        switch self {
        
        case .forecastSevendDaysByCityName( _):
            return .get
        case .forecastSevendDaysByCoord( _, _):
            return .get
        case .currentWeatherByCityName( _):
            return .get
        case .currentWeatherByZip( _):
            return .get
        case .currentWeatherByCoords(_ , _):
            return .get
        case .historicWeatherByCoords(_, _):
            return .get
        }
    }
    var task: HTTPTask {
        switch self {
            //q=London&mode=xml&units=metric&cnt=7
        case .forecastSevendDaysByCityName(let city):
            return .requestParameters(bodyParameters: [:],
                                      bodyEncoding: .urlEncoding ,
                                      urlParameters: ["q":city,
                                                      "mode":"json",
                                                      "units":"metric",
                                                      "cnt":"60",
                                                      "appid":Constants.OpenWeatherAPIKEY])
            
       
        
        case .forecastSevendDaysByCoord(let lat, let long):
            return .requestParameters(bodyParameters: [:],
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["lat": String(format:"%.8f",  lat),
                                                      "lon":String(format:"%.8f",  long),
                                                      "mode":"json",
                                                      "units":"metric",
                                                      "cnt":"60",
                                                      "appid":Constants.OpenWeatherAPIKEY])
        case .currentWeatherByCityName(let city):
            return .requestParameters(bodyParameters: [:],
                                      bodyEncoding: .urlEncoding ,
                                      urlParameters: ["q":city,
                                                      "mode":"json",
                                                      "units":"metric",
                                                      "cnt":"60",
                                                      "appid":Constants.OpenWeatherAPIKEY])
        case .currentWeatherByZip(let zip):
            return .requestParameters(bodyParameters: [:],
                                      bodyEncoding: .urlEncoding ,
                                      urlParameters: ["zip":zip,
                                                      "mode":"json",
                                                      "units":"metric",
                                                      "cnt":"60",
                                                      "appid":Constants.OpenWeatherAPIKEY])
        case .currentWeatherByCoords(let lat, let long):
            return .requestParameters(bodyParameters: [:],
                                      bodyEncoding: .urlEncoding ,
                                      urlParameters: ["lat": String(format:"%.8f",  lat),
                                                      "lon":String(format:"%.8f",  long),
                                                      "mode":"json",
                                                      "units":"metric",
                                                      "cnt":"60",
                                                      "appid":Constants.OpenWeatherAPIKEY])
       
        case .historicWeatherByCoords(let lat, let long):
            let currentHour = Date()
            print(currentHour.addingTimeInterval(-3600))
            return .requestParameters(bodyParameters: [:],
                                      bodyEncoding: .urlEncoding ,
                                      urlParameters: ["lat": String(format:"%.8f",  lat),
                                                      "lon":String(format:"%.8f",  long),
                                                      "type":"hour",
                                                      "start": String(format:"%f",currentHour.addingTimeInterval(-3600) as CVarArg ),
                                                      "end": String(format: "%f", currentHour.timeIntervalSince1970),
                                                      "mode":"json",
                                                      "units":"metric",
                                                      "cnt":"60",
                                                      "appid":Constants.OpenWeatherAPIKEY])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
}

