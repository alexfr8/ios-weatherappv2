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
}

protocol WARequestDataPresenterRouterLogic: class {
    func navigateToDataShow()
}

protocol WARequestDataStore {
    //    var name: String { get set }
}

class WARequestDataPresenter: WARequestDataPresenterLogic, WARequestDataStore {
   
    
    
    weak var view: (WARequestDataDisplayLogic & WARequestDataPresenterRouterLogic)?
    var networkManager: OpenWeatherManager?
    
    
    func setupView() {
        
        let viewModel = WARequestData.ViewModel()
        self.networkManager = OpenWeatherManager()
        view?.setupView()
        view?.setupText(viewModel: viewModel)
        
    }
    
    func manageSearchButtonClicked() {

        networkManager?.getCurrentWeatherByCoords(lat: 4.56, long: 4.56, completion: { (current, erro) in
            print(current)
        })
       
    }
    // MARK: - Services
    
}
