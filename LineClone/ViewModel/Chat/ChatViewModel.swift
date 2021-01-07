//
//  ChatViewModel.swift
//  LineClone
//
//  Created by 久保田陽人 on 2021/01/07.
//

import SwiftUI

class ChatViewModel: ObservableObject {
    
    @Published var talkrooms = [Room]()
    
    let currentUid = AuthViewModel.authShared.session?.uid
    
    init() {
        self.fetchTalkrooms()
    }
    
    func fetchTalkrooms() {
        guard let currentUid = currentUid else { return }
        ChatService.fetchTalkrooms(currentUid: currentUid) { (rooms, error) in
            if let error = error {
                print("DEBUG: Error is \(error.localizedDescription)")
                return
            }
            guard let rooms = rooms else { return }
            self.talkrooms = rooms
        }
    }
    
    func formatTimestamp(room: Room) -> String {
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "yyyy/MM/dd: HH:mm"
        let dateString = dataFormatter.string(from: room.currentTimestamp.dateValue())
        return dateString
    }
    
}


