//
//  MainPageController.swift
//  MovieApp
//
//  Created by Nilay KADİROĞULLARI on 31.07.2023.
//

import UIKit

class MainPageController: UIPageViewController {
    private var viewControllerList: [UIViewController] = {
        let storyboard = UIStoryboard.onboarding
        let firstVC = storyboard.instantiateViewController(withIdentifier: "FirstVC")
        let secondVC = storyboard.instantiateViewController(withIdentifier: "SecondVC")
        let thirdVC = storyboard.instantiateViewController(withIdentifier: "ThirdVC")
        let fourthVC = storyboard.instantiateViewController(withIdentifier: "FourthdVC")
        return [firstVC, secondVC, thirdVC, fourthVC]
    }()
    
    private var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewControllers([viewControllerList[0]], direction: .forward, animated: false, completion: nil)
    }

    func pushNext() {
        if currentIndex + 1 < viewControllerList.count {
            self.setViewControllers([self.viewControllerList[self.currentIndex + 1]], direction: .forward, animated: true, completion: nil)
            currentIndex += 1
        }
    }
}
