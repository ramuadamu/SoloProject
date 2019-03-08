//
//  UserSession.swift
//  SoloProject
//
//  Created by Ramu on 2/19/19.
//  Copyright © 2019 Ramu. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol  UserSessionAccountSignupDelegate: AnyObject {
    func didSignupAccount(_ userSession: UserSession, user: User)
    func didReceiveErrorSigningupAccount(_ userSession: UserSession, error: Error)
}

protocol  UserSessionSignOutDelegate: AnyObject {
    func didReceiveSignOutError(_ usersession: UserSession, error: Error)
    func didSignOutUser( _ usersession: UserSession)
    }

protocol UserSessionSignInDelegate: AnyObject {
    func didReceiveSignInError(_ usersession: UserSession, error: Error)
    func didSignInExistingUser( _ usersession: UserSession, user: User)
}
final class UserSession{
    weak var userSessionAccountDelegate: UserSessionAccountSignupDelegate?
    weak var usersessionSignOutDelegate: UserSessionSignOutDelegate?
    weak var usersessionSignInDelegate: UserSessionSignInDelegate?


public func signupNewAccount(email: String, password: String) {
    Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
        if let error = error {
            self.userSessionAccountDelegate?.didReceiveErrorSigningupAccount(self, error: error)
        } else if let authDataResult = authDataResult {
            self.userSessionAccountDelegate?.didSignupAccount(self, user: authDataResult.user)
            guard let username = authDataResult.user.email?.components(separatedBy: "@").first else {
                print("no email entered")
                return
            }
           DatabaseManager.firebaseDB.collection(DatabaseKeys.UserCollectionKey)
            .document(authDataResult.user.uid.description)
            .setData(["userId"      : authDataResult.user.uid,
                      "email"       : authDataResult.user.email ?? "",
                      "display"     : authDataResult.user.displayName ?? "",
                      "imageURL"    : authDataResult.user.photoURL ?? "",
                    "username"      : username
                ], completion: { (error) in
                    if let error = error {
                        print("error adding authenticated user to the database: \(error)")
                    }
            })
        }
    }
}
    
    public func updateUserAccountInfo(donor: Donor) {
        if let currentUser = getCurrentUser() {
    DatabaseManager.firebaseDB.collection(DatabaseKeys.UserCollectionKey).document(currentUser.uid.description).updateData(["name": donor.fullName,
                            "gender": donor.gender,
                            "donorId": donor.donorId,
                            "frameBrand": donor.frameBrand,
                            "frameType": donor.frameType,
                            "frameShape": donor.frameShape])
        }
    }
    
    public func updateUserAccountInfor(receiver: Receiver) {
        if let currentUser = getCurrentUser() {
            DatabaseManager.firebaseDB.collection(DatabaseKeys.UserCollectionKey).document(currentUser.uid.description).updateData(["name": receiver.fullName,
                                            "gender": receiver.gender,
                                            "donorId": receiver.receiverId])
        }
    }



public func getCurrentUser() -> User? {
    return Auth.auth().currentUser
}

public func signInExistingUser(email: String, password: String) {
    Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
        if let error = error {
            self.usersessionSignInDelegate?.didReceiveSignInError(self, error: error)
        }
    }
}

public func signOut() {
    guard let _ = getCurrentUser() else {
        print("no logged user")
        return
    }
    do {
        try Auth.auth().signOut()
        
    } catch {
        usersessionSignOutDelegate?.didReceiveSignOutError(self, error: error)
        }
    }

    public func updateUser(displayName: String?, photoURL: URL?) {
    guard let user = getCurrentUser() else {
        print("no logged user")
        return
    }
    
    
    let request = user.createProfileChangeRequest()
    request.displayName = displayName
    request.photoURL = photoURL
        request.commitChanges { (error) in
            if let error = error {
                print("error: \(error)")
            } else {
                guard let photoURL = photoURL else {
                    print("no photoURL")
                    return
                }
            }
        
}
}
}
