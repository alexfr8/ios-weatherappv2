//
//   WARequestDataPresenter.swift
//  WeatherAppv2
//
//  Created by Alejandro Fernández Ruiz on 28/07/2019.
//  Copyright © 2019 Alejandro Fernández Ruiz. All rights reserved.
//

import UIKit

protocol WARequestDataDisplayLogic: class {
    func setupView()
    func setupText(viewModel: WARequestData.ViewModel)
    func showLoading()
    func dismissLoading()
    func showError(msg: String)
}

protocol WARequestDataPresenterRouterLogic: class {
    func navigateToDataShow(zeroPosition: Current)
}

protocol WARequestDataStore {
    //    var name: String { get set }
}

class WARequestDataPresenter: WARequestDataPresenterLogic, WARequestDataStore {
    
    weak var view: (WARequestDataDisplayLogic & WARequestDataPresenterRouterLogic)?
    var networkManager: OpenWeatherManager?
    var textToSearch: String? = ""
    
    func setupView() {
        
        let viewModel = WARequestData.ViewModel()
        self.networkManager = OpenWeatherManager()
        view?.setupView()
        view?.setupText(viewModel: viewModel)
        
    }
    
    func manageSearchButtonClicked() {
       // self.view?.showLoading()
        if textToSearch?.count ?? 0 > 0 {
        if textToSearch?.isNumber ?? false  {
            networkManager?.getCurrentWeatherByZip(zip: textToSearch ?? "", completion: { (current, error) in
               //
                if (error != nil) {
                    self.view?.showError(msg: error ?? "error")
                } else {
                    if let currentWeather = current {
                         self.view?.navigateToDataShow(zeroPosition: currentWeather)
                    }else {
                        self.view?.showError(msg: "error al manejar los datos")
                    }
                   
                }
               // self.view?.dismissLoading()
            })
        } else {
            networkManager?.getCurrentWeatherByCityName(cityName: textToSearch ?? "", completion: { (current, error) in
                if (error != nil) {
                    self.view?.showError(msg: error ?? "error")
                } else {
                    if let currentWeather = current {
                        self.view?.navigateToDataShow(zeroPosition: currentWeather)
                    }else {
                        self.view?.showError(msg: "error al manejar los datos")
                    }
                    
                }
           // self.view?.dismissLoading()
            })
        }
        }
       
    }
    func setupText(text: String) {
        self.textToSearch = text
    }
    
    // MARK: - Services
    
}
