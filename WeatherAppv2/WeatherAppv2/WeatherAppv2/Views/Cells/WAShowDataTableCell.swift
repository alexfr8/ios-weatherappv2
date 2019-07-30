//
//  WAShowDataTableCell.swift
//  WeatherAppv2
//
//  Created by Alejandro Fernández Ruiz on 30/07/2019.
//  Copyright © 2019 Alejandro Fernández Ruiz. All rights reserved.
//

import UIKit


class WAShowDataTableCell : UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTitleValue: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblCityValue: UILabel!
    @IBOutlet weak var lblLat: UILabel!
    @IBOutlet weak var lblLatValue: UILabel!
    @IBOutlet weak var lblPosition: UILabel!
    @IBOutlet weak var lblPositionValue: UILabel!
    
    @IBOutlet weak var lblLong: UILabel!
    @IBOutlet weak var lblLongValue: UILabel!
    
    static var cellIdentifier: String {
        return String(describing: WAShowDataTableCell.self)
    }
    
    func updateUITemp(data : Current, index: IndexPath, position: String) {
        //cell.title.1
        lblTitle.text = NSLocalizedString("cell.title.1", comment: "")
        
        lblTitleValue.text  = String(format:"%.1f", data.main.temp)
        
        lblCity.text = NSLocalizedString("cell.city.title", comment: "")
        lblCityValue.text = data.name
        
        lblLat.text = NSLocalizedString("cell.lat.title", comment: "")
        lblLatValue.text = String(format:"%.1f", data.coord.lat)
        lblLong.text = NSLocalizedString("cell.log.title", comment: "")
        lblLongValue.text = String(format:"%.1f", data.coord.lon)
        
        lblPosition.text = NSLocalizedString("cell.position.title", comment: "")
        lblPositionValue.text = position
    }
    
    func updateUIHumidity(data : Current, index: IndexPath, position: String) {
        //cell.title.1
        lblTitle.text = NSLocalizedString("cell.title.2", comment: "")
        
        lblTitleValue.text  = String(format:"%.1f", data.main.humidity)
        
        lblCity.text = NSLocalizedString("cell.city.title", comment: "")
        lblCityValue.text = data.name
        
        lblLat.text = NSLocalizedString("cell.lat.title", comment: "")
        lblLatValue.text = String(format:"%.1f", data.coord.lat)
        lblLong.text = NSLocalizedString("cell.log.title", comment: "")
        lblLongValue.text = String(format:"%.1f", data.coord.lon)
        
        lblPosition.text = NSLocalizedString("cell.position.title", comment: "")
        lblPositionValue.text = position
    }
    
    func updateUIWind(data : Current, index: IndexPath, position: String) {
        //cell.title.1
        lblTitle.text = NSLocalizedString("cell.title.4", comment: "")
        
        lblTitleValue.text  = String(format:"%.1f", data.wind.speed)
        
        lblCity.text = NSLocalizedString("cell.city.title", comment: "")
        lblCityValue.text = data.name
        
        lblLat.text = NSLocalizedString("cell.lat.title", comment: "")
        lblLatValue.text = String(format:"%.1f", data.coord.lat)
        lblLong.text = NSLocalizedString("cell.log.title", comment: "")
        lblLongValue.text = String(format:"%.1f", data.coord.lon)
        
        lblPosition.text = NSLocalizedString("cell.position.title", comment: "")
        lblPositionValue.text = position
    }
}
