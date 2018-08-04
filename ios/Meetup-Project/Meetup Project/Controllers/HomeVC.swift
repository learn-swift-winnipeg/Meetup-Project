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
    
    @IBOutlet weak var tableview: UITableView!
    var meetups: [MeetupData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        fetchMeetups()
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

// MARK: - Network

extension HomeVC {
    func fetchMeetups() {
        appProvider.meetupApi.retrieveMeetups { (meetupResult) -> Void in
            switch meetupResult {
            case let .success(meetups):
                self.meetups = meetups
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
            case let .failure(message):
                print(message)
            }
        }
    }
}

// MARK: - Tableview management

extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meetups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "meetupCell")
        let meetup = meetups[indexPath.row]
        
        cell.textLabel?.text = meetup.name
        cell.detailTextLabel?.text = meetup.status.rawValue
        
        return cell
    }
}
