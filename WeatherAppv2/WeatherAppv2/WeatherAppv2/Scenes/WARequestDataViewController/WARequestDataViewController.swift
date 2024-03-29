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
    func setupText(text: String)
}

class WARequestDataViewController: BaseViewController {
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
    
    func showError(msg: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: NSLocalizedString("alert.title", comment: "") , message: msg, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("alert.accept", comment: ""), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
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
    func navigateToDataShow(zeroPosition: Current) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "WAShowData", bundle: nil)
            if let controller = storyboard.instantiateInitialViewController() as? WAShowDataViewController{
                controller.dataStore?.current = zeroPosition
                self.present(controller, animated: true, completion: nil)
            }
        }
        
    }
}

extension WARequestDataViewController : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.presenter?.setupText(text: self.txtInputField.text ?? "")
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
         self.presenter?.setupText(text: self.txtInputField.text ?? "")
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.presenter?.setupText(text: self.txtInputField.text ?? "")
        return true;
    }
   
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {

        return true;
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.presenter?.setupText(text: String(format: "%@%@", self.txtInputField.text ?? "", string))
        return true;
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
}
