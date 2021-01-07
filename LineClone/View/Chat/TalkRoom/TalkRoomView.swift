//
//  TalkRoomView.swift
//  LineClone
//
//  Created by 久保田陽人 on 2021/01/07.
//

import SwiftUI

struct TalkRoomView: View {
    
    @ObservedObject var viewModel: TalkRoomViewModel
    let roomId: String
    private let angle = Angle(degrees: 45.0)
    
    init(roomId: String) {
        self.roomId = roomId
        viewModel = TalkRoomViewModel(roomId: roomId)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView() {
                VStack(spacing: 16) {
                    ForEach(viewModel.messages) { message in
                        MessageCellView(message: message)
                    }
                }.padding(.top)
            }.background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
            Divider().border(Color.black, width: 2)
            HStack {
                TextField("メッセージを入力",text: $viewModel.text)
                    .font(.system(size: 16)).padding(.bottom,4)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.leading,16)
                    Button(action: {
                        viewModel.sendMessage()
                    }, label: {
                        Image(systemName: viewModel.isSendValid ? "paperplane.fill" : "paperplane")
                            .rotationEffect(angle)
                            .frame(width: 20,height: 20)
                            .padding(.horizontal)
                            .padding(.vertical,4)
                            .foregroundColor(viewModel.isSendValid ? Color(#colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1))  : Color(#colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)))
                    }).disabled(!viewModel.isSendValid)
                    .padding(.trailing,16)
                    .frame(alignment: .trailing)
            }.frame(maxWidth: .infinity).padding(.vertical,8)
        }
    }
}

//struct TalkRoomView_Previews: PreviewProvider {
//    static var previews: some View {
//        TalkRoomView()
//    }
//}
