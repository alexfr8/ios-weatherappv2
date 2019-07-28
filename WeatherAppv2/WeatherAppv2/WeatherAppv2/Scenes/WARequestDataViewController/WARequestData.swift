//
//  WARequestData.swift
//  WeatherAppv2
//
//  Created by Alejandro Fernández Ruiz on 28/07/2019.
//  Copyright © 2019 Alejandro Fernández Ruiz. All rights reserved.
//


import UIKit

enum WARequestData {
    struct Request {
    }
    struct ViewModel {
        
        
        let btnSearch: String =   NSLocalizedString("datarequest.button.title", comment: "")
        let lblTitle: String = NSLocalizedString("datarequest.titlelabel.body", comment: "")
        let lblInfoText: String =  NSLocalizedString("datarequest.infolabel.body", comment: "")
        let lblInputTitle : String = NSLocalizedString("datarequest.inputtitle.body", comment: "")
        let txtInputPlaceholder: String = NSLocalizedString("datarequest.inputtitle.body" , comment: "")
        
        
    }
}
