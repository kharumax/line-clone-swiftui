//
//  RoomCellView.swift
//  LineClone
//
//  Created by 久保田陽人 on 2021/01/07.
//

import SwiftUI
import KingfisherSwiftUI

struct RoomCellView: View {
    
    let room: Room
    
    func formatTimestamp(room: Room) -> String {
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "yyyy/MM/dd: HH:mm"
        let dateString = dataFormatter.string(from: room.currentTimestamp.dateValue())
        return dateString
    }
    
    var body: some View {
        HStack {
            KFImage(URL(string: room.partnerProfileImageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 60,height: 60)
                .cornerRadius(30)
            VStack(alignment: .leading) {
                HStack {
                    Text(room.partnerName).font(.system(size: 22,weight: .semibold)).foregroundColor(.black)
                    Spacer()
                    Text(formatTimestamp(room: room)).font(.system(size: 12,weight: .light)).foregroundColor(.black)
                }
                Text(room.currentMessage).lineLimit(2)
                    .foregroundColor(.gray)
            }
        }.padding(.horizontal).padding(.vertical,4)
    }
}

//struct RoomCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        RoomCellView()
//    }
//}
