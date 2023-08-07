//
//  LandScapeManager.swift
//  MovieApp
//
//  Created by Nilay KADİROĞULLARI on 31.07.2023.
//

import Foundation

class LandScapeManager {
    static let shared = LandScapeManager()
    var isFirstLaunch: Bool {
        get {
            !UserDefaults.standard.bool(forKey: #function)
        } set {
            UserDefaults.standard.setValue(newValue, forKey: #function)
        }
    }
}
