//
//  BaseViewController.swift
//  WeatherAppv2
//
//  Created by Alejandro Fernández Ruiz on 29/07/2019.
//  Copyright © 2019 Alejandro Fernández Ruiz. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showLoading() {
        DispatchQueue.main.async {
             self.view.showBlurLoader()
        }
       
    }
    
    func dismissLoading() {
        DispatchQueue.main.async {
            self.view.removeBluerLoader()
        }
        
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
