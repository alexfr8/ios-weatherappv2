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
    func manageClose()
    func getNumerOfRows() -> Int
    func getRowForTable(tableView:UITableView, indexPath: IndexPath) -> UITableViewCell
}


class WAShowDataViewController: BaseViewController {

    //IBOUTLETS
    
    
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
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
       tableView.register(UINib(nibName: WAShowDataTableCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: WAShowDataTableCell.cellIdentifier)
        presenter?.setupView()
        presenter?.setupCoordinates()
        presenter?.retrieveDataForCoordinates()
    }
    
    //IBActions
    
    @IBAction func btnClose(_ sender: Any) {
        self.presenter?.manageClose()
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
        DispatchQueue.main.async {
             self.tableView.reloadData()
        }
    }

    func closeScreen() {
        self.dismiss(animated: true, completion:   nil)
    }
}

extension WAShowDataViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.getNumerOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.presenter?.getRowForTable(tableView: tableView, indexPath: indexPath) ?? UITableViewCell()
    }

}
