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



