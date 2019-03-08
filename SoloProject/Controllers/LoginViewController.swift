//
//  LoginViewController.swift
//  SoloProject
//
//  Created by Ramu on 2/27/19.
//  Copyright © 2019 Ramu. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    
    
    private var userSession: UserSession!
    private var email = ""
    private var password = ""

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userSession = (UIApplication.shared.delegate as! AppDelegate).usersession
        userSession.userSessionAccountDelegate = self
        userSession.usersessionSignInDelegate = self
    }
    
    @IBAction func signupButtonPressed(_ sender: UIButton) {
        guard let email = userEmail.text, let password = userPassword.text,
            !email.isEmpty,
            !password.isEmpty else {
                showAlert(title: "Missing required fields", message: "Email and Password required", actionTitle: "Try again")
                return
        }
        userSession.signupNewAccount(email: email, password:password)

    }    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let email = userEmail.text, let password = userPassword.text,
        !email.isEmpty,
            !password.isEmpty else {
                showAlert(title: "Missing required fields", message: "Email and Password is required", actionTitle: "Try again")
                return
        }
        if let user = userSession.getCurrentUser() {
            userSession.signInExistingUser(email: email, password: password)
            userSession.usersessionSignInDelegate?.didSignInExistingUser(userSession, user: user)
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            let loginVC = storyBoard.instantiateViewController(withIdentifier: "TabBar") as! tabBarController
          present(loginVC, animated: true)
            
        }
    }
}

extension LoginViewController: UserSessionAccountSignupDelegate {
    func didSignupAccount(_ userSession: UserSession, user: User) {
        showAlert(title: "Account created", message: "New account created using \(user.email ?? "no email entered")", style: .alert) { (action) in
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let accountTypeViewController = storyboard.instantiateViewController(withIdentifier: "AccountTypeViewController") as! AccountTypeViewController
            accountTypeViewController.session = self.userSession
            self.present(accountTypeViewController, animated: true)
        }
    }
    
    func didReceiveErrorSigningupAccount(_ userSession: UserSession, error: Error) {
        showAlert(title: "Error creating account", message: error.localizedDescription, actionTitle: "Try again")
    }
}

extension LoginViewController: UserSessionSignInDelegate {
    func didReceiveSignInError(_ usersession: UserSession, error: Error) {
        showAlert(title: "Sign In Error", message: error.localizedDescription, actionTitle: "Try Again")
    }
    func didSignInExistingUser(_ usersession: UserSession, user: User) {
       showAlert(title: "user login successfully", message: "Ok", actionTitle: "Ok")
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let accountTypeViewController = storyboard.instantiateViewController(withIdentifier: "AccountTypeViewController") as! AccountTypeViewController
        accountTypeViewController.session = self.userSession
        self.present(accountTypeViewController, animated: true)
        
    }
}


extension SpectacleFeedViewController: UITextFieldDelegate {
    
}
