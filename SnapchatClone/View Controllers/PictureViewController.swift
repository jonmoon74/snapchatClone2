//
//  PictureViewController.swift
//  SnapchatClone
//
//  Created by Jon Moon on 07/07/2018.
//  Copyright © 2018 Jon Moon. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseAuth
import FirebaseDatabase


class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    var uuid = NSUUID().uuidString
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.isEnabled = false
        
        // Do any additional setup after loading the view.
        imagePicker.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image =  info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageView.image = image
        imageView.backgroundColor = UIColor.clear
        nextButton.isEnabled = true
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        
        nextButton.isEnabled = false
        
        let imagesFolder = Storage.storage().reference().child("images")
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.1)!
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        //        let storageItem = Storage.storage().reference().child(ImageUid)
        //        storageItem.putData(ImageData, metadata: metadata) { (metadata, error) in
        //            if error != nil {
        //                print("Couldn't Upload Image")
        //            } else {
        //                print("Uploaded")
        //                storageItem.downloadURL(completion: { (url, error) in
        //                    if error != nil {
        //                        print(error!)
        //                        return
        //                    }
        //                    if url != nil {
        //                        self.SetUpUser(Image: url!.absoluteString)
        //                    }
        //                }
        //            }
        //        }
        
        
        
        
        
        imagesFolder.child("\(uuid).jpg").putData(imageData, metadata: metadata, completion: {(metadata, error) in
            print ("We tried to upload")
            if error != nil {
                print ("we had an error:\(String(describing: error))")
                return()
            } else {
                imagesFolder.child("\(self.uuid).jpg").downloadURL(completion: { (url, error) in
                    if error != nil {
                        print("we had an error:\(String(describing: error))")
                        return()
                    }
                    if url != nil {
                        print("here is the url: \(String(describing: url)) ########")
                        self.performSegue(withIdentifier: "selectUserSegue", sender: url!.absoluteString)
                    }
                })
                
            }
        })
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! SelectUserViewController
        print ("Here is the sender: \(String(describing: sender))")
        nextVC.imageURL = sender as! String
        nextVC.descrip = descriptionTextField.text!
        nextVC.uuid = uuid
        
    }
}
