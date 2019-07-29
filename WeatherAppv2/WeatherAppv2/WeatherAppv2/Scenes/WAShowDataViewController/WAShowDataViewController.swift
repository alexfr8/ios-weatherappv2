//
//  WAShowDataViewController.swift
//  WeatherAppv2
//
//  Created by Alejandro Fernández Ruiz on 28/07/2019.
//  Copyright © 2019 Alejandro Fernández Ruiz. All rights reserved.
//

import UIKit


protocol WAShowDataPresenterLogic {
    func setupView()
    func setupCoordinates()
    func retrieveDataForCoordinates()
    func calculateResults()
}


class WAShowDataViewController: BaseViewController {

    //IBOUTLETS
    
    @IBOutlet weak var lblHighestTemp: UILabel!
    @IBOutlet weak var lblHighestTempValue: UILabel!
    
    @IBOutlet weak var lblHighestTempPosition: UILabel!
    
    @IBOutlet weak var lblHighestTempPositionValue: UILabel!
    
    @IBOutlet weak var lblHighestTempCity: UILabel!
    
    @IBOutlet weak var lblHighestTempCityValue: UILabel!
    
    @IBOutlet weak var lblHighestHumidity: UILabel!
    @IBOutlet weak var lblHighestHumidityValue: UILabel!
    
    @IBOutlet weak var lblHighestHumidityPosition: UILabel!
    
    @IBOutlet weak var lblHighestHumidityPositionValue: UILabel!
    
    @IBOutlet weak var lblHighestHumidityCity: UILabel!
    @IBOutlet weak var lblHighestHumidityCityValue: UILabel!
    
    
    @IBOutlet weak var lblHighestRain: UILabel!
    @IBOutlet weak var lblHighestRainValue: UILabel!
    @IBOutlet weak var lblHighestRainPosition: UILabel!
    @IBOutlet weak var lblHighestRainPositionValue: UILabel!
    @IBOutlet weak var lblHighestRainCity: UILabel!
    @IBOutlet weak var lblHighestRainCityValue: UILabel!
    
    
    
    @IBOutlet weak var lblHighestWind: UILabel!
    @IBOutlet weak var lblHighestWindValue: UILabel!
    @IBOutlet weak var lblHighestWindPosition: UILabel!
    @IBOutlet weak var lblHighestWindPositionValue: UILabel!
    @IBOutlet weak var lblHighestWindCity: UILabel!
    @IBOutlet weak var lblHighestWindCityValue: UILabel!
    
    
    //VBLES
    var presenter: WAShowDataPresenterLogic?
    var dataStore: WAShowDataStore?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupScene()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupScene()
    }
    
    // MARK: Setup
    
    private func setupScene() {
        let viewController = self
        let presenter = WAShowDataPresenter()
        
        presenter.view = viewController
        viewController.dataStore = presenter
        self.presenter = presenter
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.setupView()
        presenter?.setupCoordinates()
        presenter?.retrieveDataForCoordinates()
    }
    
    //IBActions
    
    @IBAction func btnClose(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension WAShowDataViewController : WAShowDataDisplayLogic {
   
    
   
    
    func setupView() {
        
    }
    
    func setupText(viewModel: WARequestData.ViewModel) {
        
    }
    func showError(msg: String) {
        let alert = UIAlertController(title: NSLocalizedString("alert.title", comment: "") , message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("alert.accept", comment: ""), style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func completedRetrieve() {
        self.presenter?.calculateResults()
    }

    func setupTempValues(tempValue: String, tempCity: String, tempLat: String, tempLong: String, cardinal: String) {
        
    }
    
    func setupHumidityValues(humidityValue: String, humidityCity: String, humiLat: String, humiLong: String, cardinal: String) {
        
    }
    
    func setupRainValues(rainValue: String, rainCity: String, rainLat: String, rainLong: String, cardinal: String) {
        
    }
    
    func setupWindValues(windValue: String, windCity: String, windLat: String, windLong: String, cardinal: String) {
        
    }
}
