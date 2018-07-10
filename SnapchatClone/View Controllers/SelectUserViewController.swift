//
//  SelectUserViewController.swift
//  SnapchatClone
//
//  Created by Jon Moon on 08/07/2018.
//  Copyright © 2018 Jon Moon. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class SelectUserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var users : [User] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        Database.database().reference().child("users").observe(DataEventType.childAdded, with: { (snapshot) in
            print(snapshot)
            let value = snapshot.value as? NSDictionary
            let user = User()
            user.email = value!["email"] as! String
            user.uid = snapshot.key
            
            self.users.append(user)
            self.tableView.reloadData()
        })
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        let user = users[indexPath.row]
        cell.textLabel?.text = user.email
        return cell
    }
    
}
