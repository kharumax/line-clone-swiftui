//
//  RoomCellView.swift
//  LineClone
//
//  Created by 久保田陽人 on 2021/01/07.
//

import SwiftUI

struct RoomCellView: View {
    var body: some View {
        HStack {
            Image("ironman")
                .resizable()
                .scaledToFill()
                .frame(width: 60,height: 60)
                .cornerRadius(30)
            VStack(alignment: .leading) {
                HStack {
                    Text("ironman").font(.system(size: 22,weight: .semibold)).foregroundColor(.black)
                    Spacer()
                    Text("2020/12/31 20:58").font(.system(size: 12,weight: .light)).foregroundColor(.black)
                }
                Text("yes cap,I think also . I am ironman .").lineLimit(2)
                    .foregroundColor(.gray)
            }
        }.padding(.horizontal).padding(.vertical,4)
    }
}

struct RoomCellView_Previews: PreviewProvider {
    static var previews: some View {
        RoomCellView()
    }
}
