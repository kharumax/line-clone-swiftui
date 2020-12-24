//
//  UserCellView.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/23.
//

import SwiftUI
import KingfisherSwiftUI

struct UserCellView: View {
    
    let user: User
    var body: some View {
        HStack(spacing: 20) {
            KFImage(URL(string: user.profileImageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 80,height: 80)
                .cornerRadius(40)
                .clipped()
            VStack(alignment: .leading,spacing: 10) {
                Text(user.username).font(.system(size: 18,weight: .semibold))
                Text(user.bio ?? "").font(.system(size: 14))
            }
            Spacer()
        }.padding(.horizontal,16)
    }
}

//struct UserCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserCellView()
//    }
//}
