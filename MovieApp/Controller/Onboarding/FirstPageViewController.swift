//
//  FirstPageViewController.swift
//  MovieApp
//
//  Created by Nilay KADİROĞULLARI on 31.07.2023.
//

import UIKit

class FirstPageViewController: UIViewController {
    
    @IBAction func actionButtonTapped(_ sender: UIButton) {
        if let pageController = parent as? MainPageController {
            pageController.pushNext()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
