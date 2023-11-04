//
//  LoginViewController.swift
//  MovieApp
//
//  Created by Nilay KADİROĞULLARI on 14.08.2023.
//
import FirebaseAuth
import AuthenticationServices
import UIKit
import GoogleSignIn


class LoginViewController: UIViewController {

    @IBOutlet weak var signInGoogle: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var loginImageView: UIImageView!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var UIbutton: UIButton!
    @IBOutlet weak var dontHaveSign: UILabel!
    //    @IBOutlet weak var googleSignIn: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        GIDSignIn.sharedInstance.presentingViewController = self
        
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
            let mainViewController = storyboard.instantiateViewController(withIdentifier: "mainVC")
            mainViewController.modalPresentationStyle = .fullScreen
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
                showErrorAlert(message: "Email and password required.")
                return
            }

            FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] result, error in
                guard let strongSelf = self else {
                    return
                }

                if let error = error {
                    strongSelf.showErrorAlert(message: error.localizedDescription)
                    return
                }

                UserDefaults.standard.set(true, forKey: "UserLoggedIn")
                strongSelf.saveCredentials(email: email, password: password)
                print("You are logged in")

                strongSelf.emailField.isHidden = true
                strongSelf.passwordField.isHidden = true
                strongSelf.loginImageView.isHidden = true
                strongSelf.iconImageView.isHidden = true
                strongSelf.UIbutton.isHidden = true
                strongSelf.dontHaveSign.isHidden = true

                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyboard.instantiateViewController(withIdentifier: "mainVC")
                newViewController.modalPresentationStyle = .fullScreen
                strongSelf.present(newViewController, animated: true, completion: nil)
            })
    }
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func saveCredentials(email: String, password: String) {
        let credentials = [
            kSecAttrAccount as String: email,
            kSecValueData as String: password.data(using: .utf8)!
        ] as [String : Any] as CFDictionary
        
        SecItemDelete(credentials)
        SecItemAdd(credentials, nil)
    }
    
    
    @IBAction func appleButton(_ sender: ASAuthorizationAppleIDButton) {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Failed!")
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            Auth.auth().fetchSignInMethods(forEmail: email ?? "") { (methods, error) in
                if let error = error {
                    print("Error fetching sign-in methods:", error.localizedDescription)
                    return
                }
                
                if methods?.isEmpty ?? true {
                    Auth.auth().createUser(withEmail: email ?? "", password: userIdentifier) { (authResult, error) in
                        if let error = error {
                            print("Error creating user:", error.localizedDescription)
                            return
                        }
                        
                        Auth.auth().signIn(withEmail: email ?? "", password: userIdentifier) { (authResult, error) in
                            if let error = error {
                                print("Error signing in:", error.localizedDescription)
                                return
                            }
                            
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let mainViewController = storyboard.instantiateViewController(withIdentifier: "mainVC")
                            mainViewController.modalPresentationStyle = .fullScreen
                        }
                    }
                } else {
                    Auth.auth().signIn(withEmail: email ?? "", password: userIdentifier) { (authResult, error) in
                        if let error = error {
                            print("Error signing in:", error.localizedDescription)
                            return
                        }
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let mainViewController = storyboard.instantiateViewController(withIdentifier: "mainVC")
                        mainViewController.modalPresentationStyle = .fullScreen
                    }
                }
            }
        default:
            break
        }
    }
    
}

    func signInWithAppleIDCredential(_ appleIDCredential: ASAuthorizationAppleIDCredential) {
        let identityTokenString = appleIDCredential.identityToken?.base64EncodedString() ?? ""
        let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                  idToken: identityTokenString,
                                                  rawNonce: "")
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print("Firebase Apple sign-in error:", error.localizedDescription)
                return
            }
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = storyboard.instantiateViewController(withIdentifier: "mainVC")
            mainViewController.modalPresentationStyle = .fullScreen
        }
    }

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}
