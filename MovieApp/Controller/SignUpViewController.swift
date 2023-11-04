//
//  SignUpViewController.swift
//  MovieApp
//
//  Created by Nilay Kadıroğulları on 28.08.2023.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var signUpLogo: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var infoStack: UIStackView!
    @IBOutlet weak var signLine: UILabel!
    @IBOutlet weak var signUpPasswordLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var signUpLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        
        guard let name = nameLabel.text, !name.isEmpty else {
                    showErrorAlert(message: "Please enter your name and surname.")
                    return
                }
                guard let mail = emailLabel.text, !mail.isEmpty else {
                    showErrorAlert(message: "Please enter your e-mail address.")
                    return
                }
                guard let password = signUpPasswordLabel.text, !password.isEmpty else {
                    showErrorAlert(message: "Please enter your password.")
                    return
                }
                
        Auth.auth().createUser(withEmail: mail, password: password) { [self] authResult, error in
                    if let error = error {
                        showErrorAlert(message: "An error occurred while creating the user: \(error.localizedDescription)")
                        return
                    }
                    
                    showSuccessAlert()
                }
    }
    
    func showErrorAlert(message: String) {
            let alertController = UIAlertController(
                title: "Error",
                message: message,
                preferredStyle: .alert
            )
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        
    func showSuccessAlert() {
        let alertController = UIAlertController(
            title: "Your account has been created!",
            message: "Please log in.",
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.dismiss(animated: true, completion: {
                self.navigateToLoginScreen()
            })
        })
        
        self.present(alertController, animated: true, completion: nil)
    }

    func navigateToLoginScreen() {
        if let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") {
            self.present(loginViewController, animated: true)
        }
    }
    
}
