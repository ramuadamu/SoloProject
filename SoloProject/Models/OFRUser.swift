//
//  OFRUser.swift
//  SoloProject
//
//  Created by Ramu on 2/19/19.
//  Copyright © 2019 Ramu. All rights reserved.
//

import Foundation

struct OFRUser {
    let username: String
    let imageURL: String?
    let accountType: String?
    
    init(dict: [String: Any]) {
        self.username = dict["username"] as? String ?? "no username"
        self.imageURL = dict["imageURL"] as? String ?? "no imageURL"
        self.accountType = dict["accountType"] as? String ?? ".none"
    }
}
