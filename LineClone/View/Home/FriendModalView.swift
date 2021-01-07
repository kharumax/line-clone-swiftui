//
//  FriendModalView.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/31.
//

import SwiftUI
import KingfisherSwiftUI

struct FriendModalView: View {
    
    let user: User
    let roomId: String
    @State var isShowProfileView = false
    
    var body: some View {
        VStack {
            KFImage(URL(string: user.profileImageUrl))
                .resizable()
                .frame(width: 100,height: 100)
                .cornerRadius(50)
            Text(user.username).font(.system(size: 25,weight: .semibold)).padding(.bottom,8)
            Text(user.bio ?? "").foregroundColor(.gray).font(.system(size: 20)).padding(.bottom,16)
            VStack(spacing: 10) {
                Button(action: {}, label: {
                    NavigationLink(destination: TalkRoomView(roomId: roomId).navigationTitle(user.username)) {
                        Text("トーク").foregroundColor(.white)
                            .padding(.horizontal).padding(.vertical,8)
                            .font(.system(size: 20,weight: .semibold))
                    }
                    
                }).background(Color.green).cornerRadius(10)
                NavigationLink(
                    destination: ProfileView(user: user),
                    isActive: $isShowProfileView) {
                        EmptyView()
                    }
                Button(action: { self.isShowProfileView.toggle() }, label: {
                    Text("プロフィール").foregroundColor(.white)
                        .padding(.horizontal).padding(.vertical,8)
                        .font(.system(size: 20,weight: .semibold))
                }).background(Color.green).cornerRadius(10)
            }
        }.padding(.vertical,32).padding(.horizontal,50)
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 2).fill(Color.gray))
        .background(Color.white)
    }
}

//struct FriendModalView_Previews: PreviewProvider {
//    static var previews: some View {
//        FriendModalView()
//    }
//}

/*
 
 KFImage(URL(string: user.profileImageUrl))
     .resizable()
     .frame(width: 100,height: 100)
     .cornerRadius(50)
 Text(user.username).font(.system(size: 25,weight: .semibold)).padding(.bottom,8)
 Text(user.bio ?? "").foregroundColor(.gray).font(.system(size: 20)).padding(.bottom,16)
 
 Image("ironman")
     .resizable()
     .frame(width: 100,height: 100)
     .cornerRadius(50)
 Text("ironman").font(.system(size: 25,weight: .semibold)).padding(.bottom,8)
 Text("I am ironman .").foregroundColor(.gray).font(.system(size: 20)).padding(.bottom,16)
 
 */
