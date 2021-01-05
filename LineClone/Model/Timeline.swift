//
//  Timeline.swift
//  LineClone
//
//  Created by 久保田陽人 on 2021/01/01.
//

import Foundation
import Firebase

struct Timeline: Identifiable {
    let id: String
    let uid: String
    let username: String
    let profileImageUrl: String
    let caption: String
    let imageUrl: String
    let timestamp: Timestamp
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
    }

}

func initTimeline(id: String,user: User,caption: String,imageUrl: String) -> [String: Any] {
    let data = ["id": id,"uid": user.id,"username": user.username,"profileImageUrl": user.profileImageUrl,
                "caption": caption,"imageUrl": imageUrl,"timestamp": Timestamp(date: Date())] as [String : Any]
    return data
}
