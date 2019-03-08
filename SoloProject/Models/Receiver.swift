//
//  Receiver.swift
//  SoloProject
//
//  Created by Ramu on 3/1/19.
//  Copyright © 2019 Ramu. All rights reserved.
//

import Foundation

struct  Receiver {
    let fullName: String
    let gender: String
    let receiverId: String
    let profileImageURL: String
    let userName: String
    var accountType : String = "Receiver"
    
    
    
    init(fullName: String, gender: String, receiverId: String, profileImageURL: String, userName: String) {
        self.fullName = fullName
        self.gender = gender
        self.receiverId = receiverId
        self.profileImageURL = profileImageURL
        self.userName = userName
       
 }
}
