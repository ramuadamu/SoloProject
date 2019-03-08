//
//  StorageManager.swift
//  SoloProject
//
//  Created by Ramu on 2/19/19.
//  Copyright © 2019 Ramu. All rights reserved.
//

import Foundation
import FirebaseStorage
import FirebaseAuth

protocol StorageManagerDelegate: AnyObject {
    func didFetchImage(_ storageManager: StorageManager, imageURL: URL)
}

final class StorageManager {
    weak var delegate: StorageManagerDelegate?
    
    
    private let storageRef: StorageReference = {
        let storage = Storage.storage()
        return storage.reference()
    }()


    public func postImage(withData data: Data, fileName: String) {
    guard let user = Auth.auth().currentUser else {
        print("no logged user")
        return
    }
    let imageRef = storageRef.child(StorageKeys.ImagesKey).child(fileName)
    
    let newImageRef = imageRef.child("\(user.uid).jpg")
    let metadata = StorageMetadata()
    metadata.contentType = "image/jpeg"
    let uploadTask = newImageRef.putData(data, metadata: metadata) { (metadata, error) in
        guard let metadata = metadata else {
            print("error uploading data")
            return
        }
        let _ = metadata.size
        newImageRef.downloadURL(completion: { (url, error) in
            if let error = error {
                print("downloadURL error: \(error)")
            } else if let url = url {
                print("downloadURL: \(url)")
                self.delegate?.didFetchImage(self, imageURL: url)
            }
        })
    }
    uploadTask.observe(.failure) { (StorageTaskSnapshot) in
        print("failure...")
    }
    uploadTask.observe(.pause) { (StorageTaskSnapshot) in
        print("pause...")
    }
    uploadTask.observe(.progress) { (StorageTaskSnapshot) in
        print("progress...")
    }
    uploadTask.observe(.resume) { (StorageTaskSnapshot) in
        print("resume...")
    }
    uploadTask.observe(.success) { (StorageTaskSnapshot) in
        print("success...")
        }
    }
}
