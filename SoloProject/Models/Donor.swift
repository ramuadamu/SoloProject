//
//  DonorInformation.swift
//  SoloProject
//
//  Created by Ramu on 2/19/19.
//  Copyright © 2019 Ramu. All rights reserved.
//

import Foundation

struct Donor {
    let fullName: String
    let gender: String
    let donorId: String
    let frameBrand: String
    let frameType: String
    let frameShape: String
    let profileImageURL: String
    let userName: String
    var accountType : String = "Donor"
    
    
    
    
    init(fullName: String, gender: String, donorId: String, frameBrand: String, frameType: String, frameShape: String, userProfileImageURL: String, userName: String) {
        self.fullName = fullName
        self.gender = gender
        self.donorId = donorId
        self.frameBrand = frameBrand
        self.frameType = frameType
        self.frameShape = frameShape
        self.profileImageURL = userProfileImageURL
        self.userName = userName
        
    }
    
    init(dict: [String: Any]) {
        self.fullName = dict["donorName"] as? String ?? "no donor name"
        self.gender = dict["donorGender"] as? String ?? "no donor gender"
        self.donorId = dict["donorId"] as? String ?? "donorId"
        self.frameBrand = dict["frameBrand"] as? String ?? "other"
        self.frameType = dict["frameType"] as? String ?? "other"
        self.frameShape = dict["frameShape"] as? String ?? "other"
        self.profileImageURL = dict["profileImage"] as? String ?? "no profile image"
        self.userName = dict["userName"] as? String ?? "no user name"
        self.accountType = dict["accountType"] as? String ?? "no account type"
}
}
