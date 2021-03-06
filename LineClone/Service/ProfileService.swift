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
        let friendRef = COLLECTION_USERS_FRIENDS(uid: currentUid)
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
        let friendRef = COLLECTION_USERS_FRIENDS(uid: currentUid)
        let friendPartnerRef = COLLECTION_USERS_FRIENDS(uid: uid)
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
    
    static func createChatRoom(sender: User,receiver: User,completion: @escaping(Error?) -> Void) {
        let roomsRef = COLLECTION_ROOMS.document()
        let roomData = initRoomData(sender: sender, receiver: receiver, id: roomsRef.documentID)
        roomsRef.setData(roomData) { (error) in
            if let error = error {
                completion(error)
                return
            }
            COLLECTION_USERS_ROOMS(uid: sender.id).document(roomsRef.documentID).setData(["partnerId": receiver.id]) { (error) in
                if let error = error {
                    completion(error)
                    return
                }
                COLLECTION_USERS_ROOMS(uid: receiver.id).document(roomsRef.documentID).setData(["partnerId": sender.id]) { (error) in
                    if let error = error {
                        completion(error)
                    }
                    completion(nil)
                }
            }
        }
    }
    
    static func getRoomId(currentUid: String,userId: String,completion: @escaping(String?,Error?) -> Void) {
        COLLECTION_USERS_ROOMS(uid: currentUid).whereField("partnerId", isEqualTo: userId).getDocuments { (snapshot, error) in
            if let error = error {
                completion(nil,error)
                return
            }
            guard let documents = snapshot?.documents else {
                completion(nil,nil)
                return
            }
            let roomId = documents[0].documentID
            print("DEBUG: roomId is \(roomId) / ProfileService")
            completion(roomId,nil)
        }
    }
    
    
}



