//
//  TalkRoomView.swift
//  LineClone
//
//  Created by 久保田陽人 on 2021/01/07.
//

import SwiftUI

struct TalkRoomView: View {
    
    @State var text = ""
    private let angle = Angle(degrees: 45.0)
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView() {
                VStack(spacing: 16) {
                    ForEach(1..<10) { index in
                        if (index % 3 == 0) {
                            MessageCellView(isFromCurrentUser: true)
                        } else {
                            MessageCellView(isFromCurrentUser: false)
                        }
                    }
                }
            }.background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
            Divider().border(Color.black, width: 2)
            HStack {
                TextField("メッセージを入力",text: $text)
                    .font(.system(size: 16)).padding(.bottom,4)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.leading,16)
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "paperplane")
                            .rotationEffect(angle)
                            .frame(width: 20,height: 20)
                            .padding(.horizontal)
                            .padding(.vertical,4)
                            .foregroundColor(Color(#colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)))
                    })
                    .padding(.trailing,16)
                    .frame(alignment: .trailing)
            }.frame(maxWidth: .infinity).padding(.vertical,8)
        }
    }
}

struct TalkRoomView_Previews: PreviewProvider {
    static var previews: some View {
        TalkRoomView()
    }
}
