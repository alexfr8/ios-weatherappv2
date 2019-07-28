//
//  WARequestDataViewController.swift
//  WeatherAppv2
//
//  Created by Alejandro Fernández Ruiz on 28/07/2019.
//  Copyright © 2019 Alejandro Fernández Ruiz. All rights reserved.
//

import UIKit


protocol WARequestDataPresenterLogic {
    func setupView()
    func manageSearchButtonClicked()
}

class WARequestDataViewController: UIViewController {
    //IBOutlets
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var lblInput: UILabel!
    @IBOutlet weak var txtInputField: UITextField!
    @IBOutlet weak var btnShow: UIButton!
    //VBLES
    var presenter: WARequestDataPresenterLogic?
    var dataStore: WARequestDataStore?
    
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
        let presenter = WARequestDataPresenter()
        
        presenter.view = viewController
        viewController.dataStore = presenter
        self.presenter = presenter
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
         presenter?.setupView()
    }
    
    //IBActions
    
    @IBAction func btnShow(_ sender: Any) {
        self.presenter?.manageSearchButtonClicked()
    }

}


extension WARequestDataViewController : WARequestDataDisplayLogic {
    func setupView() {
        //make all the view code changes here.
    }
    
    func setupText(viewModel: WARequestData.ViewModel) {
        self.lblTitle.text = viewModel.lblTitle
        self.lblInfo.text = viewModel.lblInfoText
        self.btnShow.setTitle(viewModel.btnSearch, for: .normal)
        self.lblInput.text = viewModel.lblInputTitle
        self.txtInputField.placeholder = viewModel.txtInputPlaceholder
        
    }
    
   
    
}

extension WARequestDataViewController : WARequestDataPresenterRouterLogic {
    func navigateToDataShow() {
        
    }
    
    
}

extension WARequestDataViewController : UITextFieldDelegate{
    
}
