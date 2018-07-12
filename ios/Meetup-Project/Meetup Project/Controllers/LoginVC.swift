//
//  LoginVC.swift
//  Meetup Project
//
//  Created by sebastien FOCK CHOW THO on 2018-07-08.
//  Copyright © 2018 sebastien FOCK CHOW THO. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    lazy var appProvider = AppProvider.shared

    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

// MARK: - Actions

extension LoginVC {
    @IBAction func didRequestLogin() {
        guard let usernameVal = usernameLabel.text, !usernameVal.isEmpty else {
            // TODO: - Report error: username required
            return
        }
        
        guard let passwordVal = passwordLabel.text, !passwordVal.isEmpty else {
            // TODO: - Report error: password required
            return
        }
        
        let loginResult = appProvider.loginManager.login(withUsername: usernameVal, andPassword: passwordVal)
        
        guard loginResult.success else {
            let alert = UIAlertController(title: "Authentication Failed", message: loginResult.message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            
            present(alert, animated: true)
            return
        }
        
        // TODO: - login passing user...
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let navigation = storyboard.instantiateInitialViewController() as! UINavigationController
        present(navigation, animated: true)
    }
}
