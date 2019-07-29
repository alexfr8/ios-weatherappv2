//
//  WAShowDataPresenter.swift
//  WeatherAppv2
//
//  Created by Alejandro Fernández Ruiz on 28/07/2019.
//  Copyright © 2019 Alejandro Fernández Ruiz. All rights reserved.
//

import Foundation
import MapKit

protocol WAShowDataDisplayLogic: class {
    func setupView()
    func setupText(viewModel: WARequestData.ViewModel)
    func showError(msg:String)
    func completedRetrieve()
    func setupTempValues(tempValue: String, tempCity: String, tempLat: String, tempLong: String, cardinal:String)
    func setupHumidityValues(humidityValue: String, humidityCity: String, humiLat: String, humiLong: String, cardinal:String)
    func setupRainValues(rainValue: String, rainCity: String, rainLat: String, rainLong: String, cardinal:String)
    func setupWindValues(windValue: String, windCity: String, windLat: String, windLong: String, cardinal:String)
}



protocol WAShowDataStore {
    //    var name: String { get set }
    var current: Current? {get set}
}

class WAShowDataPresenter: WAShowDataPresenterLogic, WAShowDataStore {
   
    
  
    
   
    weak var view: WAShowDataDisplayLogic?
    var networkManager: OpenWeatherManager?
    var current: Current?
    var northPosition: CLLocationCoordinate2D?
    var westPosition: CLLocationCoordinate2D?
    var southPosition: CLLocationCoordinate2D?
    var eastPosition: CLLocationCoordinate2D?
    
    var northCurrentWeather: Current?
    var southCurrenWeather: Current?
    var westCurrentWeather: Current?
    var eastCurrentWeather: Current?
    
    func setupView() {
        
        let viewModel = WARequestData.ViewModel()
        self.networkManager = OpenWeatherManager()
        view?.setupView()
        view?.setupText(viewModel: viewModel)
        
    }
    
    func setupCoordinates() {
        
        eastPosition = UtilsCoord.shared.coordinates(startingCoordinates:  CLLocationCoordinate2D(latitude: current?.coord.lat ?? 0, longitude: current?.coord.lon ?? 0), atDistance: Constants.kmForCalculating, atAngle: 90)
        
        
        westPosition = UtilsCoord.shared.coordinates(startingCoordinates: CLLocationCoordinate2D(latitude: current?.coord.lat ?? 0,
                                                                                                 longitude: current?.coord.lon ?? 0),
                                                     atDistance: Constants.kmForCalculating,
                                                     atAngle: 270)
        
        northPosition = UtilsCoord.shared.coordinates(startingCoordinates: CLLocationCoordinate2D(latitude: current?.coord.lat ?? 0,
                                                                                                  longitude: current?.coord.lon ?? 0),
                                                      atDistance: Constants.kmForCalculating,
                                                      atAngle: 0)
        
        southPosition = UtilsCoord.shared.coordinates(startingCoordinates: CLLocationCoordinate2D(latitude: current?.coord.lat ?? 0,
                                                                                                  longitude: current?.coord.lon ?? 0),
                                                      atDistance: Constants.kmForCalculating,
                                                      atAngle: 180)
        
        
    }
    
    func retrieveDataForCoordinates() {
        let groupForCurrents = DispatchGroup()
        groupForCurrents.enter()
        networkManager?.getCurrentWeatherByCoords(lat: northPosition?.latitude ?? 0, long: northPosition?.longitude ?? 0, completion: { (northCurrentResponse, error) in
            if error != nil {
                self.view?.showError(msg: error ?? "")
            } else {
                self.northCurrentWeather = northCurrentResponse
            }
            groupForCurrents.leave()
        })
         groupForCurrents.enter()
        networkManager?.getCurrentWeatherByCoords(lat: westPosition?.latitude ?? 0, long: westPosition?.longitude ?? 0, completion: { (westCurrentResponse, error) in
            if error != nil {
                self.view?.showError(msg: error ?? "")
            } else {
                self.westCurrentWeather = westCurrentResponse
            }
            groupForCurrents.leave()
        })
         groupForCurrents.enter()
        networkManager?.getCurrentWeatherByCoords(lat: southPosition?.latitude ?? 0, long: southPosition?.longitude ?? 0, completion: { (southCurrentResponse, error) in
            if error != nil {
                self.view?.showError(msg: error ?? "")
            } else {
                self.southCurrenWeather = southCurrentResponse
            }
            groupForCurrents.leave()
        })
         groupForCurrents.enter()
        networkManager?.getCurrentWeatherByCoords(lat: eastPosition?.latitude ?? 0, long: eastPosition?.longitude ?? 0, completion: { (eastCurrentResponse, error) in
            if error != nil {
                self.view?.showError(msg: error ?? "")
            } else {
                self.eastCurrentWeather = eastCurrentResponse
            }
            groupForCurrents.leave()
        })
        groupForCurrents.notify(queue: DispatchQueue.main) {
            print("hola")
            self.view?.completedRetrieve()
        }
    }
    
    func calculateResults() {
        
    }
   
    
    private func calculateTempResults() {
    
    }
    // MARK: - Services
    
}
