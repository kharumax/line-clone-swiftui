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
    // MessageInfo
    let currentMessage: String
    let currentTimestamp: Timestamp
    // partnerInfo
    var partnerUid: String
    var partnerName: String
    var partnerProfileImageUrl: String
    
    init(dictionary: [String: Any],currentUid: String) {
        self.id = dictionary["id"] as? String ?? ""
        self.senderName = dictionary["senderName"] as? String ?? ""
        self.senderUid = dictionary["senderUid"] as? String ?? ""
        self.senderProfileImageUrl = dictionary["senderProfileImageUrl"] as? String ?? ""
        self.receiverName = dictionary["receiverName"] as? String ?? ""
        self.receiverUid = dictionary["receiverUid"] as? String ?? ""
        self.receiverProfileImageUrl = dictionary["receiverProfileImageUrl"] as? String ?? ""
        self.currentMessage = dictionary["currentMessage"] as? String ?? ""
        self.currentTimestamp = dictionary["currentTimestamp"] as? Timestamp ?? Timestamp(date: Date())
        // partnerInfo
        self.partnerUid = currentUid == dictionary["senderUid"] as! String ?
            dictionary["receiverUid"] as! String : dictionary["senderUid"] as! String
        self.partnerName = currentUid == dictionary["senderUid"] as! String ?
            dictionary["receiverName"] as! String : dictionary["senderName"] as! String
        self.partnerProfileImageUrl = currentUid == dictionary["senderUid"] as! String ?
            dictionary["receiverProfileImageUrl"] as! String : dictionary["senderProfileImageUrl"] as! String
    }
}

func initRoomData(sender: User,receiver: User,id: String) -> [String: Any] {
    let data = [
        "id": id,"senderName": sender.username,"senderUid": sender.id,"senderProfileImageUrl": sender.profileImageUrl,
        "receiverName": receiver.username,"receiverUid": receiver.id,"receiverProfileImageUrl": receiver.profileImageUrl,
        "currentMessage": "","currentTimestamp": Timestamp(date: Date())
    ] as [String: Any]
    return data
}

