//
//  ChatView.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/20.
//

import SwiftUI

struct ChatView: View {
    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<10) { _ in
                    NavigationLink(
                        destination: LazyView(TalkRoomView().navigationTitle("ironman")),
                        label: {
                            RoomCellView()
                        })
                }
            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
