//
//  Message.swift
//  LineClone
//
//  Created by 久保田陽人 on 2021/01/07.
//

import Foundation
import Firebase

struct Message: Identifiable {
    let id: String
    let uid: String
    let username: String
    let profileImageUrl: String
    let text: String
    let timestamop: Timestamp
    let isFromCurrentUser: Bool
    
    init(dictionary: [String: Any],currentUid: String) {
        self.id = dictionary["id"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.text = dictionary["text"] as? String ?? ""
        self.timestamop = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.isFromCurrentUser = dictionary["uid"] as! String == currentUid ? true : false
    }
}

func initMessageData(user: User,text: String,id: String) -> [String: Any] {
    let data = [
        "id": id,"uid": user.id,"username": user.username,"profileImageUrl": user.profileImageUrl,
        "text": text,"timestamp": Timestamp(date: Date())
    ] as [String: Any]
    return data
}
