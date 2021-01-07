//
//  ChatService.swift
//  LineClone
//
//  Created by 久保田陽人 on 2021/01/07.
//

import Foundation
import Firebase


struct ChatService {
    
    static func fetchTalkrooms(currentUid: String,completion: @escaping([Room]?,Error?) -> Void) {
        COLLECTION_USERS_ROOMS(uid: currentUid).getDocuments { (snapshot, error) in
            if let error = error {
                completion(nil,error)
                return
            }
            guard let documents = snapshot?.documents else {
                completion(nil,nil)
                return
            }
            let roomIds = documents.map({ $0.documentID }) as [String]
            print("DEBUG: roomIds is \(roomIds) at ChatService")
            // MARK: -- ここでは上で取得したIDで(where id in [1,2,...n])と同じ処理を行なっている
            COLLECTION_ROOMS.whereField("id", in: roomIds).order(by: "currentTimestamp",descending: true).addSnapshotListener { (snapshot, error) in
                if let error = error {
                    completion(nil,error)
                    return
                }
                guard let roomsDocs = snapshot?.documents else {
                    completion(nil,nil)
                    return
                }
                let rooms = roomsDocs.map({ Room(dictionary: $0.data(), currentUid: currentUid) })
                print("DEBUG: rooms is \(rooms) at ChatService")
                completion(rooms,nil)
            }
        }
    }
    
    // MARK: -- これで本当にリアルタイムチャットになっているか実機で確認
    static func fetchMessages(roomId: String,currentUid: String,completion: @escaping([Message]?,Error?) -> Void) {
        let roomsRef = COLLECTION_ROOMS.document(roomId).collection("messages").order(by: "timestamp")
        roomsRef.addSnapshotListener { (snapshot, error) in
            print("DEBUG: roomsRef.addSnapshotListener is called / ChatService / fetchMessages")
            if let error = error {
                completion(nil,error)
                return
            }
            guard let documents = snapshot?.documents else {
                completion(nil,nil)
                return
            }
            let messages = documents.map({ Message(dictionary: $0.data(), currentUid: currentUid) })
            print("DEBUG: messages is \(messages) / ChatService / fetchMessages")
            completion(messages,nil)
            
        }
//        roomsRef.addSnapshotListener { (snapshot, error) in
//            print("DEBUG: roomsRef.addSnapshotListener is called / ChatService / fetchMessages")
//            print("DEBUG: messages is \(messages) / ChatService / fetchMessages")
//            if let error = error {
//                completion(nil,error)
//                return
//            }
//            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else {
//                completion(nil,nil)
//                return
//            }
//            var newMessages: [Message] = messages
//            print("DEBUG: newMessages is \(newMessages) / ChatService / fetchMessages")
//            changes.forEach { (change) in
//                let message = Message(dictionary: change.document.data(), currentUid: currentUid)
//                print("DEBUG: sendMessage is \(message)  / ChatService / fetchMessages")
//                newMessages.append(message)
//            }
//            print("DEBUG: newMessages is \(newMessages) / ChatService / fetchMessages")
//            completion(newMessages,nil)
//        }
    }
    
    static func sendMessage(roomId: String,user: User,text: String,completion: @escaping(Error?) -> Void) {
        let messagesRef = COLLECTION_ROOMS.document(roomId).collection("messages").document()
        let roomRef = COLLECTION_ROOMS.document(roomId)
        let data = initMessageData(user: user, text: text, id: messagesRef.documentID)
        messagesRef.setData(data) { (error) in
            if let error = error {
                completion(error)
                return
            }
            let updateData = ["currentMessage": text,"currentTimestamp": Timestamp(date: Date())] as [String : Any]
            roomRef.updateData(updateData) { (error) in
                if let error = error {
                    completion(error)
                    return
                }
                completion(nil)
            }
        }
    }
    
}
