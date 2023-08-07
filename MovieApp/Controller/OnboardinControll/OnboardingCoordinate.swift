//
//  OnboardingCoordinate.swift
//  MovieApp
//
//  Created by Nilay KADİROĞULLARI on 3.08.2023.
//

import UIKit

class OnboardingCoordinate {
    static func markOnboardingAsShown() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "hasShownOnboarding")
    }
}
