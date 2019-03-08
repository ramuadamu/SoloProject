//
//  ProfileViewController.swift
//  SoloProject
//
//  Created by Ramu on 2/14/19.
//  Copyright © 2019 Ramu. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UIButton!
    @IBOutlet weak var accountType: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var gender: UILabel!
    
    
    private var tapGesture: UITapGestureRecognizer!
    private var imagePickerViewController: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesturePressed))
        profileImage.addGestureRecognizer(tapGesture)
}
    
    @objc func setupProfileImage() {
        imagePickerViewController = UIImagePickerController()
        imagePickerViewController.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        }
        present(imagePickerViewController, animated: true, completion: nil)
    }
    
    @objc func setProfileImageAlertController() {
        let alert = UIAlertController(title: "Options", message: "", preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Camera", style: .default) { (alert: UIAlertAction) in self.setupProfileImage()
        }
        let photoLibrary = UIAlertAction(title: "Photo Library", style: .default) { (alert: UIAlertAction) in
            self.setupProfileImage()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (alert: UIAlertAction) in
            self.setupProfileImage()
        }
        present(alert, animated: true, completion: nil)
    }
     @objc func tapGesturePressed() {
        setupProfileImage()
    }
}
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        profileImage.image = originalImage
        dismiss(animated: true, completion: nil)
    }
    }

