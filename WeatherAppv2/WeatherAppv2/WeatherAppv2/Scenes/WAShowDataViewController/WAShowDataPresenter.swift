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
    func closeScreen()
    func completedRetrieve()
}

protocol WAShowDataStore {
  
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
    
    var tempMax: String?
    var humidityMax: String?
    var rainMax: String?
    var windMax: String?
    let groupForCurrents = DispatchGroup()
    
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
    
    func manageClose() {
        self.view?.closeScreen()
    }
    
    func retrieveDataForCoordinates() {
        
        self.retrieveDataForNorth()
        self.retrieveDataForSouth()
        self.retrieveDataForEast()
        self.retrieveDataForWest()
        
        groupForCurrents.notify(queue: .main) {
            self.view?.completedRetrieve()
        }
    }
    
    private func retrieveDataForNorth() {
        groupForCurrents.enter()
        networkManager?.getCurrentWeatherByCoords(lat: northPosition?.latitude ?? 0, long: northPosition?.longitude ?? 0, completion: { (northCurrentResponse, error) in
            if error != nil {
                self.view?.showError(msg: error ?? "")
            } else {
                self.northCurrentWeather = northCurrentResponse
            }
            self.groupForCurrents.leave()
        })
    }
   
    private func retrieveDataForSouth() {
        groupForCurrents.enter()
        networkManager?.getCurrentWeatherByCoords(lat: southPosition?.latitude ?? 0, long: southPosition?.longitude ?? 0, completion: { (southCurrentResponse, error) in
            if error != nil {
                self.view?.showError(msg: error ?? "")
            } else {
                self.southCurrenWeather = southCurrentResponse
            }
            self.groupForCurrents.leave()
        })
    }
    
    private func retrieveDataForEast() {
        groupForCurrents.enter()
        networkManager?.getCurrentWeatherByCoords(lat: eastPosition?.latitude ?? 0, long: eastPosition?.longitude ?? 0, completion: { (eastCurrentResponse, error) in
            if error != nil {
                self.view?.showError(msg: error ?? "")
            } else {
                self.eastCurrentWeather = eastCurrentResponse
            }
           self.groupForCurrents.leave()
        })
    }
    
    private func retrieveDataForWest() {
        groupForCurrents.enter()
        networkManager?.getCurrentWeatherByCoords(lat: westPosition?.latitude ?? 0, long: westPosition?.longitude ?? 0, completion: { (westCurrentResponse, error) in
            if error != nil {
                self.view?.showError(msg: error ?? "")
            } else {
                self.westCurrentWeather = westCurrentResponse
            }
            self.groupForCurrents.leave()
        })
        
    }
    private func calculateTempResults() -> Current? {
        var max = current
        self.tempMax = Constants.cardinalPoints.origin.rawValue
        if northCurrentWeather != nil, Unicode.CanonicalCombiningClass(rawValue: UInt8((max?.main.temp)!)) < Unicode.CanonicalCombiningClass(rawValue: UInt8((northCurrentWeather?.main.temp)!)) {
            max = northCurrentWeather
            self.tempMax = Constants.cardinalPoints.north.rawValue
        }
        
        if southCurrenWeather != nil, Unicode.CanonicalCombiningClass(rawValue: UInt8((max?.main.temp)!)) < Unicode.CanonicalCombiningClass(rawValue: UInt8((southCurrenWeather?.main.temp)!)) {
            max = southCurrenWeather
            self.tempMax = Constants.cardinalPoints.south.rawValue
        }
        
        if eastCurrentWeather != nil , Unicode.CanonicalCombiningClass(rawValue: UInt8((max?.main.temp)!)) < Unicode.CanonicalCombiningClass(rawValue: UInt8((eastCurrentWeather?.main.temp)!)) {
            max = eastCurrentWeather
            self.tempMax = Constants.cardinalPoints.east.rawValue
        }
        
        if westCurrentWeather != nil , Unicode.CanonicalCombiningClass(rawValue: UInt8((max?.main.temp)!)) < Unicode.CanonicalCombiningClass(rawValue: UInt8((westCurrentWeather?.main.temp)!)) {
            max = westCurrentWeather
            self.tempMax = Constants.cardinalPoints.west.rawValue
        }
        
        
        return max
    }
    
    private func calculateHumidityResults() -> Current? {
       
        var max = current
        self.humidityMax = Constants.cardinalPoints.origin.rawValue
        if northCurrentWeather != nil, Unicode.CanonicalCombiningClass(rawValue: UInt8((max?.main.humidity)!)) < Unicode.CanonicalCombiningClass(rawValue: UInt8((northCurrentWeather?.main.humidity)!)) {
            max = northCurrentWeather
            self.humidityMax = Constants.cardinalPoints.north.rawValue
        }
        
        if southCurrenWeather != nil, Unicode.CanonicalCombiningClass(rawValue: UInt8((max?.main.humidity)!)) < Unicode.CanonicalCombiningClass(rawValue: UInt8((southCurrenWeather?.main.humidity)!)) {
            max = southCurrenWeather
            self.humidityMax = Constants.cardinalPoints.south.rawValue
        }
        
        if  eastCurrentWeather != nil, Unicode.CanonicalCombiningClass(rawValue: UInt8((max?.main.humidity)!)) < Unicode.CanonicalCombiningClass(rawValue: UInt8((eastCurrentWeather?.main.humidity)!)) {
            max = eastCurrentWeather
            self.humidityMax = Constants.cardinalPoints.east.rawValue
        }
        
        if westCurrentWeather != nil, Unicode.CanonicalCombiningClass(rawValue: UInt8((max?.main.humidity)!)) < Unicode.CanonicalCombiningClass(rawValue: UInt8((westCurrentWeather?.main.humidity)!)) {
            max = westCurrentWeather
            self.humidityMax = Constants.cardinalPoints.west.rawValue
        }
        
        return max
    }
    
    private func calculateWindResults() -> Current? {
        
        var max = current
        self.windMax = Constants.cardinalPoints.origin.rawValue
        if northCurrentWeather != nil, Unicode.CanonicalCombiningClass(rawValue: UInt8((max?.wind.speed)!)) < Unicode.CanonicalCombiningClass(rawValue: UInt8((northCurrentWeather?.wind.speed)!)) {
            max = northCurrentWeather
            self.windMax = Constants.cardinalPoints.north.rawValue
        }
        
        if southCurrenWeather != nil, Unicode.CanonicalCombiningClass(rawValue: UInt8((max?.wind.speed)!)) < Unicode.CanonicalCombiningClass(rawValue: UInt8((southCurrenWeather?.wind.speed)!)) {
            max = southCurrenWeather
            self.windMax = Constants.cardinalPoints.south.rawValue
        }
        
        if eastCurrentWeather != nil, Unicode.CanonicalCombiningClass(rawValue: UInt8((max?.wind.speed)!)) < Unicode.CanonicalCombiningClass(rawValue: UInt8((eastCurrentWeather?.wind.speed)!)) {
            max = eastCurrentWeather
            self.windMax = Constants.cardinalPoints.east.rawValue
        }
        
        if westCurrentWeather != nil, Unicode.CanonicalCombiningClass(rawValue: UInt8((max?.wind.speed)!)) < Unicode.CanonicalCombiningClass(rawValue: UInt8((westCurrentWeather?.wind.speed)!)) {
            max = westCurrentWeather
            self.windMax = Constants.cardinalPoints.west.rawValue
        }
        
        return max
    }
    // MARK: - Services
    
    
    //MARK: - TABLEVIEW
    
    func getRowForTable(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WAShowDataTableCell.cellIdentifier) as? WAShowDataTableCell else {
            return UITableViewCell()
        }
       
        if indexPath.row == 0, current != nil{
            if let tempResult = calculateTempResults() {
                cell.updateUITemp(data: tempResult, index: indexPath, position: tempMax ?? "")
            }
        }
        
        if indexPath.row == 1, current != nil {
            if let humidityResult = calculateHumidityResults() {
                cell.updateUIHumidity(data: humidityResult, index: indexPath, position: humidityMax ?? "")
            }
        }
        
        if indexPath.row == 3, current != nil {
            if let windResult = calculateWindResults() {
                cell.updateUIWind(data: windResult, index: indexPath, position: windMax ?? "")
            }
        }
        return cell
    }
}
