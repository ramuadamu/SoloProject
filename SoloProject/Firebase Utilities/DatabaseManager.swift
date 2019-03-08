//
//  DatabaseManager.swift
//  SoloProject
//
//  Created by Ramu on 2/27/19.
//  Copyright © 2019 Ramu. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


final class DatabaseManager {
    private init(){}
    static let firebaseDB: Firestore = {
        let db = Firestore.firestore()
        
        return db
    }()
    
    static func saveSpectacle(spectacle: UserSpectacle) {
        firebaseDB.collection("userSpectacles").addDocument(data: ["fileName" : spectacle.fileName])
        
    }
    
    static func addSpectacle(spectacle: Spectacle) {
        var ref : DocumentReference? = nil
        ref = firebaseDB.collection(DatabaseKeys.FrameCollectionKey).addDocument(data:["imageURL": spectacle.spectacleImageURL,
                                                                           "spectacleBrand": spectacle.spectacleBrand, "spectacleShape": spectacle.spectacleShape, "spectacleType": spectacle.spectacleType,
                                                                        "userId":                      spectacle.userId
    ], completion: { (error) in
    if let error = error {
        print("posting spectacle failer with error: \(error)")
    } else {
        print("post created at ref: \(ref?.documentID ?? "no doc id")")
        DatabaseManager.firebaseDB.collection(DatabaseKeys.FrameCollectionKey).document(ref!.documentID)
            .updateData(["documentId": ref!.documentID], completion: { (error) in
                if let error = error {
                    print("error updating field: \(error)")
                } else {
                    print("field updated")
                }
            })
        }
                                                                            
    })
    }
    
    
    static func getSpectacle(completion: @escaping (([UserSpectacle]) -> Void)) {
        var finalArray = [UserSpectacle]()
        
        firebaseDB.collection("userSpectacles").addSnapshotListener { (snapshot, error) in
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let createdSpectacle = UserSpectacle.init(dictionary: document.data())
                    finalArray.append(createdSpectacle)
                }
                completion(finalArray)
            }
        }
    }
    
}

