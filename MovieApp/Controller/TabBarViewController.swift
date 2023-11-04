//
//  TabBarViewController.swift
//  MovieApp
//
//  Created by Nilay Kadıroğulları on 5.09.2023.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    var isActivityIndicatorRunning = false
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.barTintColor = UIColor(red: 1, green: 0.78, blue: 0, alpha: 0.5)
//        // Tab bar'ın arka plan rengini ve bir miktar şeffaflığını ayarla
//        tabBar.barTintColor = UIColor(red: 1, green: 0.78, blue: 0, alpha: 0) // Alpha değerini artırın
        tabBar.isTranslucent = true
//
//        // Tab bar'ın köşelerini keskin bırak
//        tabBar.layer.cornerRadius = 0
//        tabBar.layer.masksToBounds = true
    }
}

