//
//  ProfileService.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/24.
//

import SwiftUI
import Firebase

struct ProfileService {
    
    static func IsFriendUser(currentUid: String,uid: String,completion: @escaping(Bool?,Error?) -> Void) {
        let friendRef = COLLECTION_USERS.document(currentUid).collection("friend")
        friendRef.document(uid).getDocument { (snapshot, error) in
            if let error = error {
                completion(nil,error)
                return
            }
            completion(snapshot?.exists,nil)
        }
    }
    
    static func updateProfileImage(currentUid: String,image: UIImage?,completion: @escaping(String?,Error?) -> Void) {
        guard let imageData = image!.jpegData(compressionQuality: 0.3) else { return }
        let filename = "\(currentUid)_\(NSUUID().uuidString)"
        let storageRef = STORAGE_USERS.child(filename)
        storageRef.putData(imageData,metadata: nil) { (_, error) in
            if let error = error {
                completion(nil,error)
                return
            }
            storageRef.downloadURL { (url, error) in
                if let error = error {
                    completion(nil,error)
                    return
                }
                completion(url?.absoluteString,nil)
            }
        }
    }
    
    static func updateProfile(user: User,username: String,bio: String,imageUrl: String,completion: @escaping(User?,Error?) -> Void ) {
        let usersRef = COLLECTION_USERS.document(user.id)
        var data = ["username": username,"bio": bio,"profileImageUrl": imageUrl]
        usersRef.updateData(data) { (error) in
            if let error = error {
                completion(nil,error)
                return
            }
            data["uid"] = user.id
            data["email"] = user.email
            let user = User(dictionary: data)
            completion(user,nil)
        }
    }
    
    static func addFriend(currentUid: String,uid: String,completion: @escaping(Error?) -> Void) {
        let friendRef = COLLECTION_USERS.document(currentUid).collection("friend")
        let friendPartnerRef = COLLECTION_USERS.document(uid).collection("friend")
        friendRef.document(uid).setData([:]) { error in
            if let error = error {
                completion(error)
                return
            }
            friendPartnerRef.document(currentUid).setData([:]) { error in
                if let error = error {
                    completion(error)
                    return
                }
                completion(nil)
            }
        }
    }
    
    
}



