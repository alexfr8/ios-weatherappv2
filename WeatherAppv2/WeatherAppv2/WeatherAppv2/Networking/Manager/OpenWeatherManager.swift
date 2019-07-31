//
//  OpenWeatherManager.swift
//  WeatherApp
//
//  Created by Alejandro Fernández Ruiz on 6/10/18.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation



enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String>{
    case success
    case failure(String)
}

struct OpenWeatherManager {
    static var appEnvironment : NetworkEnvironment = .apiForescast
    
    let router = Router<OpenWeatherEndPoint>()
    
    func getCurrentWeatherByCityName(cityName: String,completion: @escaping (_ response : Current?, _ error: String?) -> ()) {
        OpenWeatherManager.appEnvironment = .apiForescast
        router.request(.currentWeatherByCityName(city: cityName)) { (data, response, error) in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        print(responseData)
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print(jsonData)
                        let current = try JSONDecoder().decode(Current.self, from: responseData)
                        print(current)
                        completion(current, nil)
                    }catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
        
    }
    
    func getCurrentWeatherByZip(zip: String,completion: @escaping (_ response : Current?, _ error: String?) -> ()) {
        OpenWeatherManager.appEnvironment = .apiForescast
        router.request(.currentWeatherByZip(zip: zip)) { (data, response, error) in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        print(responseData)
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print(jsonData)
                        let current = try JSONDecoder().decode(Current.self, from: responseData)
                        print(current)
                        completion(current, nil)
                    }catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
        
    }
    
    func getCurrentWeatherByCoords(lat: Double, long: Double, completion: @escaping (_ response : Current?, _ error: String?) -> ()) {
        OpenWeatherManager.appEnvironment = .apiForescast
        router.request(.currentWeatherByCoords(lat: lat, long: long)) { (data, response, error) in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        print(responseData)
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print(jsonData)
                        let current = try JSONDecoder().decode(Current.self, from: responseData)
                        print(current)
                        completion(current, nil)
                    }catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
        
    }
    
    func getSevenDaysForecastByCoordinates(lat: Double, long: Double, completion: @escaping (_ response : SevenDaysForecasting?, _ error: String?) -> ()) {
        OpenWeatherManager.appEnvironment = .apiForescast
        router.request(.forecastSevendDaysByCoord(lat: lat, long: long)) { (data, response, error) in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        print(responseData)
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print(jsonData)
                        let sevendDaysForecast = try JSONDecoder().decode(SevenDaysForecasting.self, from: responseData)
                        print(sevendDaysForecast)
                        completion(sevendDaysForecast, nil)
                    }catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        
        }
    }
    
    func getSevenDaysForecastByCityName(cityName: String,completion: @escaping (_ response : SevenDaysForecasting?, _ error: String?) -> ()) {
        OpenWeatherManager.appEnvironment = .apiForescast
        router.request(.forecastSevendDaysByCityName(city: cityName)) { (data, response, error) in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                                case .success:
                                    guard let responseData = data else {
                                        completion(nil, NetworkResponse.noData.rawValue)
                                        return
                                    }
                                    do {
                                        print(responseData)
                                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                                        print(jsonData)
                                        let sevendDaysForecast = try JSONDecoder().decode(SevenDaysForecasting.self, from: responseData)
                                        print(sevendDaysForecast)
                                        completion(sevendDaysForecast, nil)
                                    }catch {
                                        print(error)
                                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                                    }
                                case .failure(let networkFailureError):
                                    completion(nil, networkFailureError)
                                }
                            }
        }
        
    }
    
    func getHistoricWeatherByCoords(lat: Double, long: Double, completion: @escaping (_ response : Current?, _ error: String?) -> ()) {
        OpenWeatherManager.appEnvironment = .historyData
        router.request(.historicWeatherByCoords(lat: lat, long: long)) { (data, response, error) in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        print(responseData)
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print(jsonData)
                        let current = try JSONDecoder().decode(Current.self, from: responseData)
                        print(current)
                        completion(current, nil)
                    }catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
        
    }
    
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
