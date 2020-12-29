//
//  Room.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/29.
//

import Foundation
import Firebase

struct Room: Identifiable {
    let id: String
    // senderInfo
    let senderName: String
    let senderUid: String
    let senderProfileImageUrl: String
    // receiverInfo
    let receiverName: String
    let receiverUid: String
    let receiverProfileImageUrl: String
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String ?? ""
        self.senderName = dictionary["senderName"] as? String ?? ""
        self.senderUid = dictionary["senderUid"] as? String ?? ""
        self.senderProfileImageUrl = dictionary["senderProfileImageUrl"] as? String ?? ""
        self.receiverName = dictionary["receiverName"] as? String ?? ""
        self.receiverUid = dictionary["receiverUid"] as? String ?? ""
        self.receiverProfileImageUrl = dictionary["receiverProfileImageUrl"] as? String ?? ""
    }
}

func initRoomData(sender: User,receiver: User,id: String) -> [String: Any] {
    let data = [
        "id": id,"senderName": sender.username,"senderUid": sender.id,"senderProfileImageUrl": sender.profileImageUrl,
        "receiverName": receiver.username,"receiverUid": receiver.id,"receiverProfileImageUrl": receiver.profileImageUrl
    ]
    return data
}
