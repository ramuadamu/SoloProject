//
//  AddSpectacleViewController.swift
//  SoloProject
//
//  Created by Ramu on 3/6/19.
//  Copyright © 2019 Ramu. All rights reserved.
//

import UIKit

class AddSpectacleViewController: UIViewController {
    
    @IBOutlet weak var spectacleBrandPicker: UIPickerView!
    @IBOutlet weak var spectacleTypeButton: UIButton!
    @IBOutlet weak var spectacleShapeButton: UIButton!
    @IBOutlet weak var spectacleImage: UIImageView!
    @IBOutlet weak var spectacleBrandLabel: UILabel!
    private var tapGesture: UITapGestureRecognizer!
    private var imagePickerViewController: UIImagePickerController!
    var userSession: UserSession!
    var storageManager: StorageManager!
    var spectacleType = ""
    var spectacleShape = ""
    var spectacleBrand = ""
    var spectacleBrands = ["Burberry", "Celine", "Dior", "Dolce & Gabbana", "Fendi", "Givenchy", "Gucci", "Jimmy Choo", "Oakley", "Oliver Peoples", "Paul Smith", "Persol", "Polaroid", "RayBan", "Tiffany & Co", "Tom Ford", "Versace", "Warby Parker"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSaveButton()
        setupCancelButton()
        tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tapPressed))
        spectacleImage.addGestureRecognizer(tapGesture)
        spectacleBrandPicker.dataSource = self
        spectacleBrandPicker.delegate = self
        userSession = (UIApplication.shared.delegate as! AppDelegate).usersession
        storageManager = (UIApplication.shared.delegate as! AppDelegate).storageManager
         storageManager.delegate = self

        
    }
    
    func setImageAlertController() {
        let alert = UIAlertController(title: "Select Image from camera roll or photo library", message: "", preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Camera", style: .default) { (alert: UIAlertAction) in
            self.setupImagePicker()
        }
        let photoLibrary = UIAlertAction(title: "Photo Library", style: .default) { (alert: UIAlertAction) in
           self.setupImagePicker()
            }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (alert: UIAlertAction) in
            self.setupImagePicker()
        }
        alert.addAction(camera)
        alert.addAction(photoLibrary)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    func setupImagePicker() {
        imagePickerViewController = UIImagePickerController()
        imagePickerViewController.delegate = self
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        }
        present(imagePickerViewController, animated: true, completion: nil)
    }

    
    @objc func tapPressed() {
        setImageAlertController()
    }
    
    @IBAction func spectacleTypeButtonPressed(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Select Your Spectacle Type", message: "Full Rimmed ?? Rimless ?? Semi Rimless ?? Other", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Full Rimmed", style: .default, handler: { (action) in
            self.spectacleType = "Full Rimmed"
            self.spectacleTypeButton.setTitle(self.spectacleType, for: .normal)
        }))
        alertController.addAction(UIAlertAction(title: "Rimless", style: .default, handler: { (action) in
            self.spectacleType = "Rimless"
            self.spectacleTypeButton.setTitle(self.spectacleType, for: .normal)
        }))
        alertController.addAction(UIAlertAction(title: "Semi Rimless", style: .default, handler: { (action) in
            self.spectacleType = "Semi Rimless"
            self.spectacleTypeButton.setTitle(self.spectacleType, for: .normal)
        }))
        alertController.addAction(UIAlertAction(title: "Other", style: .default, handler: { (action) in
            self.spectacleType = "Other"
            self.spectacleTypeButton.setTitle(self.spectacleType, for: .normal)
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertController, animated: true)
    }
    
    @IBAction func spectacleShapeButtonPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Choose Your Frame Shape",
                                                message: "round" ?? "square" ?? "wayfarer" ??
                                                    "rectangle" ?? "oval" ?? "aviator" ?? "other", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Round", style: .default, handler: { (action) in
            self.spectacleShape = "Round"
            self.spectacleShapeButton.setTitle(self.spectacleShape, for: .normal)
        }))
        alertController.addAction(UIAlertAction(title: "Square", style: .default, handler: { (action) in
            self.spectacleShape = "Square"
            self.spectacleShapeButton.setTitle(self.spectacleShape, for: .normal)
        }))
        alertController.addAction(UIAlertAction(title: "Wayfarer", style: .default, handler: { (action) in
            self.spectacleShape = "Wayfarer"
            self.spectacleShapeButton.setTitle(self.spectacleShape, for: .normal)
        }))
        alertController.addAction(UIAlertAction(title: "Rectange", style: .default, handler: { (action) in
            self.spectacleShape = "Rectangle"
            self.spectacleShapeButton.setTitle(self.spectacleShape, for: .normal)
        }))
        alertController.addAction(UIAlertAction(title: "Oval", style: .default, handler: { (action) in
            self.spectacleShape = "Oval"
            self.spectacleShapeButton.setTitle(self.spectacleShape, for: .normal)
        }))
        alertController.addAction(UIAlertAction(title: "Aviator", style: .default, handler: { (action) in
            self.spectacleShape = "Aviator"
            self.spectacleShapeButton.setTitle(self.spectacleShape, for: .normal)
        }))
        alertController.addAction(UIAlertAction(title: "Other", style: .default, handler: { (action) in
            self.spectacleShape = "Other"
            self.spectacleShapeButton.setTitle(self.spectacleShape, for: .normal)
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertController, animated: true)
    }
    func setupSaveButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Save", style: .plain, target: self, action: #selector(saveButtonPressed))
    }
    
    func setupCancelButton() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonPressed))
    }
    
    @objc func saveButtonPressed() {
        guard let data = spectacleImage.image?.jpegData(compressionQuality: 0.5) else {
            return
        }
        storageManager.postImage(withData: data, fileName: spectacleBrand)
       
        }
    
    
    @objc func cancelButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    }



extension AddSpectacleViewController: UIPickerViewDelegate, UIPickerViewDataSource  {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return spectacleBrands.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return spectacleBrands[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedSpectacleBrand = spectacleBrands[row]
        spectacleBrand = selectedSpectacleBrand
        spectacleBrandLabel.text = spectacleBrand
    }
}
extension AddSpectacleViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        spectacleImage.image = originalImage
        dismiss(animated: true, completion: nil)
        }
}
extension AddSpectacleViewController: StorageManagerDelegate {
    func didFetchImage(_ storageManager: StorageManager, imageURL: URL) {
        let spectacle = Spectacle.init(spectacleImageURL:imageURL.absoluteString , spectacleBrand: spectacleBrand, spectacleShape: spectacleShape, spectacleType: spectacleType, userId: userSession.getCurrentUser()?.uid ?? "no user id", documentId: "")
        DatabaseManager.addSpectacle(spectacle: spectacle)
        dismiss(animated: true, completion: nil)
        
    }
}
