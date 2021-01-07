//
//  MessageCellView.swift
//  LineClone
//
//  Created by 久保田陽人 on 2021/01/07.
//

import SwiftUI

struct MessageCellView: View {
    
    let isFromCurrentUser: Bool
    
    var body: some View {
        ZStack {
            if isFromCurrentUser {
                HStack(alignment: .bottom) {
                    Spacer()
                    Text("18:10").font(.system(size: 12)).padding(.bottom,10)
                    Text("yes cap,I think also . I am ironman .yes cap,I think also . I am ironman .yes cap,I think also . I am ironman .yes cap,I think also . I am ironman .")
                        .padding(.trailing,10).padding(.vertical,10)
                        .padding(.leading,5)
                        .background(Color(#colorLiteral(red: 0.5563425422, green: 0.9793455005, blue: 0, alpha: 1)))
                        .cornerRadius(20)
                }.padding(.trailing,16)
            } else {
                HStack(alignment: .top) {
                    Image("ironman")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30,height: 30)
                        .cornerRadius(15)
                    VStack(alignment: .leading) {
                        Text("ironman").font(.system(size: 14)).padding(.leading,5)
                        HStack(alignment: .bottom) {
                            Text("yes cap,I think also . I am ironman .yes cap,I think also . I am ironman .yes cap,I think also . I am ironman .yes cap,I think also . I am ironman .")
                                .padding(.trailing,10).padding(.vertical,10)
                                .padding(.leading,5)
                                .background(Color.white)
                                .cornerRadius(20)
                                
                            Text("18:10").font(.system(size: 12))
                        }
                    }
                    Spacer()
                }.padding(.horizontal).padding(.vertical,4)
            }
        }
    }
}

struct MessageCellView_Previews: PreviewProvider {
    static var previews: some View {
        MessageCellView(isFromCurrentUser: true)
    }
}
