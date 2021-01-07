//
//  TalkRoomViewModel.swift
//  LineClone
//
//  Created by 久保田陽人 on 2021/01/07.
//

import SwiftUI

class TalkRoomViewModel: ObservableObject {
    
    @Published var messages = [Message]()
    @Published var text = ""
    let user = AuthViewModel.authShared.user
    let roomId: String
    var isSendValid: Bool {
        return !text.isEmpty
    }
    
    init(roomId: String) {
        self.roomId = roomId
        self.fetchMessages()
    }
    
    func fetchMessages() {
        print("DEBUG: fetchMessages is called")
        guard let user = user else { return }
        ChatService.fetchMessages(roomId: roomId, currentUid: user.id) { (messages, error) in
            if let error = error {
                print("DEBUG: Error is \(error.localizedDescription)")
                return
            }
            guard let messages = messages else { return }
            self.messages = messages
        }
    }
    
    func sendMessage() {
        print("DEBUG: sendMessage is called and now message.count is \(self.messages.count)")
        guard let user = user else { return }
        ChatService.sendMessage(roomId: roomId, user: user, text: text) { (error) in
            self.text = ""
            if let error = error {
                print("DEBUG: Error is \(error.localizedDescription)")
            }
            print("DEBUG: sendMessage is fin and now message.count is \(self.messages.count)")
        }
    }
    
}
