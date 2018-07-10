//
//  SignInViewController.swift
//  SnapchatClone
//
//  Created by Jon Moon on 01/07/2018.
//  Copyright © 2018 Jon Moon. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var getInvolvedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func getInvolvedTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: {(user, error) in
            print ("We tried to sign in")
            if error != nil {
                print ("We have an error:\(String(describing: error))")
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    print("We tried to create a user")
                    
                    if error != nil {
                        print ("We have an error:\(String(describing: error))")
                    } else {
                        print ("Successfully created user")
                        
                        Database.database().reference().child("users").child(user!.user.uid).child("email").setValue(user!.user.email!)
                        
                        self.performSegue(withIdentifier: "signInSegue", sender: nil)
                    }
                })
            } else {
                print ("We signed in successfully")
                self.performSegue(withIdentifier: "signInSegue", sender: nil)
            }
        })
        
        
    }
    
    
}

