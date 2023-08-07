//
//  LaunchScreenController.swift
//  MovieApp
//
//  Created by Nilay KADİROĞULLARI on 28.07.2023.
//

import UIKit

class LaunchScreenController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let activityIndicatorController = ActivityViewController()
        
        self.navigationController?.pushViewController(activityIndicatorController, animated: false)
    }
}
