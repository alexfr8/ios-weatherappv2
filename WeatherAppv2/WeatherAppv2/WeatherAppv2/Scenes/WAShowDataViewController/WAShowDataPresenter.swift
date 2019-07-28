//
//  WAShowDataPresenter.swift
//  WeatherAppv2
//
//  Created by Alejandro Fernández Ruiz on 28/07/2019.
//  Copyright © 2019 Alejandro Fernández Ruiz. All rights reserved.
//

import Foundation


protocol WAShowDataDisplayLogic: class {
    func setupView()
    func setupText(viewModel: WARequestData.ViewModel)
}



protocol WAShowDataStore {
    //    var name: String { get set }
}

class WAShowDataPresenter: WAShowDataPresenterLogic, WAShowDataStore {
    
    
    
    weak var view: WAShowDataDisplayLogic?
    var networkManager: OpenWeatherManager?
    
    
    func setupView() {
        
        let viewModel = WARequestData.ViewModel()
        self.networkManager = OpenWeatherManager()
        view?.setupView()
        view?.setupText(viewModel: viewModel)
        
    }
    
   
    // MARK: - Services
    
}
