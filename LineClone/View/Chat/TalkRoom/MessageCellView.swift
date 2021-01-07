//
//  MessageCellView.swift
//  LineClone
//
//  Created by 久保田陽人 on 2021/01/07.
//

import SwiftUI
import KingfisherSwiftUI

struct MessageCellView: View {
    
    let message: Message
    
    func formatTimestamp(message: Message) -> String {
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "yyyy/MM/dd: HH:mm"
        let dateString = dataFormatter.string(from: message.timestamop.dateValue())
        return dateString
    }
    
    var body: some View {
        ZStack {
            if message.isFromCurrentUser {
                HStack(alignment: .bottom) {
                    Spacer()
                    Text(formatTimestamp(message: message)).font(.system(size: 12)).padding(.bottom,10)
                    Text(message.text)
                        .padding(10)
                        .background(Color(#colorLiteral(red: 0.5563425422, green: 0.9793455005, blue: 0, alpha: 1)))
                        .cornerRadius(20)
                }.padding(.trailing,16)
            } else {
                HStack(alignment: .top) {
                    KFImage(URL(string: message.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30,height: 30)
                        .cornerRadius(15)
                    VStack(alignment: .leading) {
                        Text(message.username).font(.system(size: 14)).padding(.leading,5)
                        HStack(alignment: .bottom) {
                            Text(message.text)
                                .padding(.trailing,10).padding(.vertical,10)
                                .padding(.leading,5)
                                .background(Color.white)
                                .cornerRadius(20)
                                
                            Text(formatTimestamp(message: message)).font(.system(size: 12))
                        }
                    }
                    Spacer()
                }.padding(.horizontal).padding(.vertical,4)
            }
        }
    }
}

//struct MessageCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageCellView(isFromCurrentUser: true)
//    }
//}
