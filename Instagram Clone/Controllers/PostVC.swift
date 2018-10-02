//
//  PostVC.swift
//  Instagram Clone
//
//  Created by Matthew on 10/1/18.
//  Copyright © 2018 Matthew. All rights reserved.
//

import UIKit
import Parse

class PostVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageToPost: UIImageView!
    @IBOutlet weak var captionField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add tap functionalities to imageToPost
        let didTapImage = UITapGestureRecognizer(target: self, action: #selector(setImagePicker))
        imageToPost.isUserInteractionEnabled = true
        imageToPost.addGestureRecognizer(didTapImage)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // instantiate an image picker object and present
    // view controller when imageToPost is tapped
    @objc func setImagePicker() {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        
        // If camera is available, present camera, else present photo library
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        
        self.present(vc, animated: true, completion: nil)
    }
    
    // Implement delegate method for UIImagePickerController
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        // Get the image captured by the UIImagePickerController
        
        if let editedImage = info[.editedImage] as? UIImage {
            imageToPost.image = editedImage
            print("Edited image was chosen")
        } else if let originalImage = info[.originalImage] as? UIImage {
            imageToPost.image = originalImage
            print("Original image was chosen")
        } else {
            print("Error choosing image")
        }
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    // Function to publish image and caption to Parse

    @IBAction func didTapShare(_ sender: Any) {
        print("Publishing...")
        
        // resize image before publishing
        let resizedImage = resize(image: imageToPost.image!, newSize: CGSize(width: 1000, height: 1000))
        
        // call .postUserImage method from Post class
        Post.postUserImage(image: resizedImage, withCaption: captionField.text) { (success, error) in
            if success {
                // do something (maybe getFeed, reloadData of tableview)
                print("Photo published.")
            } else {
                print("Error. Unable to publish.")
            }
        }
    }
    
    // func to resize image so that photos published to Parse are <10 MB
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizeImageView.contentMode = UIView.ContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
}
