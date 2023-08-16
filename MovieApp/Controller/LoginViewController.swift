//
//  LoginViewController.swift
//  MovieApp
//
//  Created by Nilay KADİROĞULLARI on 14.08.2023.
//
import FirebaseAuth
import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var UIbutton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginshown = UserDefaults.standard.bool(forKey: "OnboardingViewController")
        if !loginshown {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginViewController = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController")
            loginViewController.modalPresentationStyle = .fullScreen
            present(loginViewController, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let userLoggedIn = UserDefaults.standard.bool(forKey: "UserLoggedIn")
        let userCreatedAccount = UserDefaults.standard.bool(forKey: "UserCreatedAccount")
        
        if userLoggedIn || userCreatedAccount {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = storyboard.instantiateViewController(withIdentifier: "SpaceViewController")
            mainViewController.modalPresentationStyle = .fullScreen
            present(mainViewController, animated: true, completion: nil)
            self.dismiss(animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailField.becomeFirstResponder()
    }
    @IBAction func continueButton(_ sender: UIButton) {
        
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty
        else {
            return
        }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: {[weak self]result, error in
            guard let strongSelf = self else {
                return
            }
            
            guard error == nil else {
                
                strongSelf.showCreateAccount(email: email, password: password)
                return
            }
            
            UserDefaults.standard.set(true, forKey: "UserLoggedIn")
            strongSelf.saveCredentials(email: email, password: password)
            print("You have signed in")
            
            strongSelf.emailField.isHidden = true
            strongSelf.passwordField.isHidden = true
            strongSelf.loginLabel.isHidden = true
            strongSelf.UIbutton.isHidden = true
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyboard.instantiateViewController(withIdentifier: "SpaceViewController")
            newViewController.modalPresentationStyle = .fullScreen
            strongSelf.present(newViewController, animated: true, completion: nil)
            strongSelf.dismiss(animated: true)
        })
    }
    
    func showCreateAccount(email: String, password: String) {
        let alert = UIAlertController(title: "Create Account",
                                      message: "Would you like to create an account",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue",
                                      style: .default,
                                      handler: {_ in
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: {[weak self] result, error in
                guard let strongSelf = self else {
                    return
                }
                
                guard error == nil else {
                    print("Account creation failed")
                    return
                }
                
                UserDefaults.standard.set(true, forKey: "UserCreatedAccount")
                strongSelf.saveCredentials(email: email, password: password)
                print("You have created")
                
                strongSelf.emailField.isHidden = true
                strongSelf.passwordField.isHidden = true
                strongSelf.loginLabel.isHidden = true
                strongSelf.UIbutton.isHidden = true
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyboard.instantiateViewController(withIdentifier: "SpaceViewController")
                newViewController.modalPresentationStyle = .fullScreen
                strongSelf.present(newViewController, animated: true, completion: nil)
                strongSelf.self.dismiss(animated: true)
            })
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in
        }))
        
        present(alert, animated: true)
    }
    
    func saveCredentials(email: String, password: String) {
        let credentials = [
            kSecAttrAccount as String: email,
            kSecValueData as String: password.data(using: .utf8)!
        ] as [String : Any] as CFDictionary
        
        SecItemDelete(credentials)
        SecItemAdd(credentials, nil)
    }
}
