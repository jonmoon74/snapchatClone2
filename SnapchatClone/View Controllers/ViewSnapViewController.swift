//
//  ViewSnapViewController.swift
//  SnapchatClone
//
//  Created by Jon Moon on 13/07/2018.
//  Copyright © 2018 Jon Moon. All rights reserved.
//

import UIKit


class ViewSnapViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var snap = Snap()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = snap.descrip
    }

    
}
