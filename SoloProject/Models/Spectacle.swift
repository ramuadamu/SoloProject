//
//  Spectacle.swift
//  
//
//  Created by Ramu on 2/27/19.
//

import Foundation

struct Spectacle: Codable {
    let spectacleImageURL: String
    let spectacleBrand: String
    let spectacleShape: String
    let spectacleType: String
    let userId: String
    let documentId: String
    
    init(spectacleImageURL: String, spectacleBrand: String, spectacleShape: String, spectacleType: String, userId: String, documentId: String) {
        self.spectacleImageURL = spectacleImageURL
        self.spectacleBrand = spectacleBrand
        self.spectacleShape = spectacleShape
        self.spectacleType = spectacleType
        self.userId = userId
        self.documentId = documentId
        
    }
    
    init(dict: [String: Any]) {
        self.spectacleImageURL = dict["imageURL"] as? String ?? "no spectacle image"
        self.spectacleBrand = dict["spectacleBrand"] as? String ?? "no spectacle brand"
        self.spectacleShape = dict["spectacleShape"] as? String ?? "other"
        self.spectacleType = dict["spectacleType"] as? String ?? "other"
        self.userId = dict["userId"] as? String ?? "no user id"
        self.documentId = dict["documentId"] as? String ?? "no dbReference"
        
    }
}
