//
//  ActivityViewController.swift
//  MovieApp
//
//  Created by Nilay KADİROĞULLARI on 27.07.2023.
////
//
import UIKit

class ActivityViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        DispatchQueue.main.async {
//            self.activityIndicator?.startAnimating()
//        }
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//                self.activityIndicator?.stopAnimating()
//                self.navigateToMainViewController()
//            }
//        }
    
    func navigateToMainViewController() {
        let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainViewControllerIdentifier") as! ViewController
        
        let navigationController = UINavigationController(rootViewController: mainViewController)
        
        navigationController.modalPresentationStyle = .fullScreen
        
        self.present(navigationController, animated: true, completion: nil)
    }
}
