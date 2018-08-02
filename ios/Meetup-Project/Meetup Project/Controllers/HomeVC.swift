//
//  HomeVC.swift
//  Meetup Project
//
//  Created by sebastien FOCK CHOW THO on 2018-07-05.
//  Copyright © 2018 sebastien FOCK CHOW THO. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    lazy var appProvider = AppProvider.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

// MARK: - UI

extension HomeVC {
    func setupNavigation() {
        let logoutButton = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(logout))
        navigationItem.setLeftBarButton(logoutButton, animated: true)
    }
}

// MARK: - Actions

extension HomeVC {
    @objc func logout() {
        appProvider.loginManager.oauth2Logout()
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let loginVC = storyboard.instantiateInitialViewController() as! LoginVC
        
        present(loginVC, animated: true)
    }
}
