//
//  AccountTypeViewController.swift
//  SoloProject
//
//  Created by Ramu on 2/27/19.
//  Copyright © 2019 Ramu. All rights reserved.
//

import UIKit

class AccountTypeViewController: UIViewController {
    
    @IBOutlet weak var accountType: UIButton!
    @IBOutlet weak var accountName: UITextField!
    @IBOutlet weak var gender: UIButton!
    @IBOutlet weak var frameType: UIButton!
    @IBOutlet weak var frameBrandLabel: UILabel!
    @IBOutlet weak var frameBrandPicker: UIPickerView!
    @IBOutlet weak var frameShape: UIButton!
    @IBOutlet weak var submit: UIButton!
    
    var session: UserSession!
    var userAccountType = ""
    var fullName = ""
    var userGender = ""
    var userFrameBrand = ""
    var userFrameBrands = ["Burberry", "Celine", "Dior", "Dolce_Gabbana", "Fendi", "Givenchy", "Gucci", "Jimmy_Choo", "Oakley", "Oliver_Peoples", "Paul_Smith", "Persol", "Polaroid", "Ray_Ban", "Tiffany_Co", "Tom_Ford", "Versace", "Warby_Parker"]
    var userFrameType = ""
    var userFrameShape = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        frameBrandPicker.dataSource = self
        frameBrandPicker.delegate = self
        accountName.delegate = self
        
    }
    
    
    @IBAction func accountTypeButtonPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "choose account type", message: "", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Donor Account", style: .default, handler: { (action) in
            self.userAccountType = "Donor Account"
            self.accountType.setTitle(self.userAccountType, for: .normal)
        }))
        alertController.addAction(UIAlertAction(title: "Receiver Account", style: .default, handler: { (action) in
            self.userAccountType = "Receiver Account"
            self.accountType.setTitle(self.userAccountType, for: .normal)
        }))
        present(alertController, animated: true)
    }
    
    @IBAction func genderButtonPressed(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Choose gender", message: "", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Male", style: .default, handler: { (action) in
        self.userGender = "Male"
            self.gender.setTitle(self.userGender, for: .normal)
    }))
        alertController.addAction(UIAlertAction(title: "Female", style: .default, handler: { (action) in
        self.userGender = "Female"
            self.gender.setTitle(self.userGender, for: .normal)
     }))
        present(alertController, animated: true)
    }
    @IBAction func frameTpePressed(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Choose your frame type", message: "Full Rimmed ?? Rimless ?? Semi Rimless ?? Other", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Full Rimmed", style: .default, handler: { (action) in
            self.userFrameType = "Full Rimmed"
            self.frameType.setTitle(self.userFrameType, for: .normal)
        }))
        alertController.addAction(UIAlertAction(title: "Rimless", style: .default, handler: { (action) in
            self.userFrameType = "Rimless"
            self.frameType.setTitle(self.userFrameType, for: .normal)
        }))
        alertController.addAction(UIAlertAction(title: "Semi Rimless", style: .default, handler: { (action) in
            self.userFrameType = "Semi Rimless"
            self.frameShape.setTitle(self.userFrameType, for: .normal)
        }))
        alertController.addAction(UIAlertAction(title: "Other", style: .default, handler: { (action) in
            self.userFrameType = "Other"
            self.frameType.setTitle(self.userFrameType, for: .normal)
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertController, animated: true)
    }
    
    @IBAction func frameShapeButtonPressed(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Choose your frame shape",
                                                message: "round" ?? "square" ?? "wayfarer" ??
                                                    "rectangle" ?? "oval" ?? "aviator" ?? "other", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Round", style: .default, handler: { (action) in
            self.userFrameShape = "Round"
            self.frameShape.setTitle(self.userFrameShape, for: .normal)
        }))
        alertController.addAction(UIAlertAction(title: "Square", style: .default, handler: { (action) in
            self.userFrameShape = "Square"
            self.frameShape.setTitle(self.userFrameShape, for: .normal)
        }))
        alertController.addAction(UIAlertAction(title: "Wayfarer", style: .default, handler: { (action) in
            self.userFrameShape = "Wayfarer"
            self.frameShape.setTitle(self.userFrameShape, for: .normal)
        }))
        alertController.addAction(UIAlertAction(title: "Rectange", style: .default, handler: { (action) in
            self.userFrameShape = "Rectangle"
            self.frameShape.setTitle(self.userFrameShape, for: .normal)
        }))
        alertController.addAction(UIAlertAction(title: "Oval", style: .default, handler: { (action) in
            self.userFrameShape = "Oval"
            self.frameShape.setTitle(self.userFrameShape, for: .normal)
        }))
        alertController.addAction(UIAlertAction(title: "Aviator", style: .default, handler: { (action) in
            self.userFrameShape = "Aviator"
            self.frameShape.setTitle(self.userFrameShape, for: .normal)
        }))
        alertController.addAction(UIAlertAction(title: "Other", style: .default, handler: { (action) in
            self.userFrameShape = "Other"
            self.frameShape.setTitle(self.userFrameShape, for: .normal)
        }))
        present(alertController, animated: true)
    }
}
    extension AccountTypeViewController: UIPickerViewDelegate, UIPickerViewDataSource  {
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return userFrameBrands.count
        }
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return userFrameBrands[row]
        }
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            let selectedFrameBrand = userFrameBrands[row]
            userFrameBrand = selectedFrameBrand
            frameBrandLabel.text = selectedFrameBrand
            
            //self.delegate?.accountFrameShapePicked(accountframeShape: frameShape[row])
        }
    @IBAction func submitPressed(_ sender: Any) {
        if userAccountType == "Donor" {
            let newDonor = Donor(fullName: fullName, gender: userGender, donorId: "", frameBrand: userFrameBrand, frameType: userFrameType, frameShape: userFrameShape, userProfileImageURL: "", userName: "")
            session.updateUserAccountInfo(donor: newDonor)
        
        } else {
            if userAccountType == "Receiver" {
                let newReceiver = Receiver(fullName: "name", gender: "gender", receiverId: "receiverId", profileImageURL: "", userName: "")
                session.updateUserAccountInfor(receiver: newReceiver)
            }
        }
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let loginVC = storyBoard.instantiateViewController(withIdentifier: "TabBar") as! tabBarController
        present(loginVC, animated: true)
       
        }
}

extension AccountTypeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard let fullName = accountName.text else {
            fatalError("fatal error")
        }
        if !fullName.contains(" ") {
            showAlert(title: "first and last name is required", message: "enter your first name and last name", actionTitle: "Try Again")
        }
        self.fullName = fullName
        
        textField.resignFirstResponder()
        return true
    }
}
