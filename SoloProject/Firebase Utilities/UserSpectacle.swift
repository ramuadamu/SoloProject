//
//  UserSpectacle.swift
//  SoloProject
//
//  Created by Ramu on 2/27/19.
//  Copyright © 2019 Ramu. All rights reserved.
//

import Foundation

struct UserSpectacle: Codable {
    
    let fileName: String
    init(fileName: String) {
        self.fileName = fileName
    }
    
    init(dictionary:[String: Any]) {
        self.fileName = dictionary["fileName"] as? String ?? "no filename"
    }
}
