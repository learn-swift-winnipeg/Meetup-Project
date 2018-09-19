//
//  ChatRoomVC.swift
//  Meetup Project
//
//  Created by sebastien FOCK CHOW THO on 2018-09-18.
//  Copyright © 2018 sebastien FOCK CHOW THO. All rights reserved.
//

import UIKit

class ChatRoomVC: UIViewController {
    
    lazy var appProvider = AppProvider.shared
    
    var meetup: MeetupData? = nil
    var feed: [ChatData] = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDatasource()
    }

}

// MARK: - Setup

extension ChatRoomVC {
    func setupDatasource() {
        if let meetup = meetup {
            feed = appProvider.backend.retrieveChat(forMeetup: meetup)
        }
    }
}

// MARK: - Table management

extension ChatRoomVC: UITableViewDataSource, UITabBarDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "tmp")
        let chatData = feed[indexPath.row]
        
        cell.textLabel?.text = chatData.body
        cell.detailTextLabel?.text = "By \(chatData.user.username) at \(chatData.time.description)"
        
        return cell
    }
}
