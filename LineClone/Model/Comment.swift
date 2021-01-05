//
//  Comment.swift
//  LineClone
//
//  Created by 久保田陽人 on 2021/01/05.
//

import Foundation
import Firebase

struct Comment: Identifiable {
    let id: String
    let uid: String
    let username: String
    let profileImageUrl: String
    let text: String
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.text = dictionary["text"] as? String ?? ""
    }
}

func initComment(id: String,user: User,text: String) -> [String: Any] {
    let data = ["id": id,"uid": user.id,"username": user.username,"profileImageUrl": user.profileImageUrl,"text": text]
    return data
}
