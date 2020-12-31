//
//  FriendCell.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/31.
//

import SwiftUI
import KingfisherSwiftUI

struct FriendCell: View {
    
    let user: User
    var body: some View {
        HStack {
            KFImage(URL(string: user.profileImageUrl))
                .resizable()
                .frame(width: 50,height: 50)
                .cornerRadius(25)
            VStack(alignment: .leading,spacing: 5) {
                Text(user.username).font(.system(size: 18,weight: .semibold)).foregroundColor(.black)
                Text(user.bio ?? "").foregroundColor(.gray)
            }
            Spacer()
        }
    }
}

//struct FriendCell_Previews: PreviewProvider {
//    static var previews: some View {
//        FriendCell()
//    }
//}
