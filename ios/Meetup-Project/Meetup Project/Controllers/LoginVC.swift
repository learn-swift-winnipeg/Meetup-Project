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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserDefaults.standard.object(forKey: OAuthConstants.meetupAccessToken) != nil {
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let navigation = storyboard.instantiateInitialViewController() as! UINavigationController
            
            present(navigation, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

// MARK: - Actions

extension LoginVC {
    @IBAction func didRequestLogin() {
        appProvider.loginManager.oauth2Login(self)
    }
}
