//
//  ChatView.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/20.
//

import SwiftUI

struct ChatView: View {
    
    @ObservedObject var viewModel = ChatViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.talkrooms) { room in
                    NavigationLink(
                        destination: LazyView(TalkRoomView(roomId: room.id).navigationTitle(room.partnerName)),
                        label: {
                            RoomCellView(room: room)
                        })
                }
            }
        }
    }
}

//struct ChatView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatView()
//    }
//}
