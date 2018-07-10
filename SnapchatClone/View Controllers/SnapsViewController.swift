//
//  SnapsViewController.swift
//  SnapchatClone
//
//  Created by Jon Moon on 05/07/2018.
//  Copyright © 2018 Jon Moon. All rights reserved.
//

import UIKit

class SnapsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func logoutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
