//
//  ProfileView.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/23.
//

import SwiftUI
import KingfisherSwiftUI

struct ProfileView: View {
    private let user: User
    @ObservedObject var viewModel: ProfileViewModel
    @State private var isShowLogoutAlert = false
    
    init(user: User) {
        self.user = user
        self.viewModel = ProfileViewModel(user: user)
        print("DEBUG: isCurrentUser is \(viewModel.isCurrentUser)")
    }
    
    var body: some View {
        VStack {
            KFImage(URL(string: viewModel.user.profileImageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 250,height: 250)
                .cornerRadius(125)
                .clipped()
                .padding(.bottom,24)
            Text(viewModel.user.username).font(.system(size: 20,weight: .semibold))
                .padding(.bottom,16)
            Text(viewModel.user.bio ?? "").font(.system(size: 16)).lineLimit(5)
                .padding(.horizontal,40)
                .padding(.bottom,24)
            ProfileActionButton(viewModel: viewModel)
            ZStack {
                if viewModel.isCurrentUser {
                    HStack {
                        Button(action: {
                            self.isShowLogoutAlert.toggle()
                        }, label: {
                            Text("ログアウト")
                                .foregroundColor(.green)
                                .font(.system(size: 20,weight: .semibold))
                        }).padding()
                        .alert(isPresented: $isShowLogoutAlert) {
                            Alert(title: Text("ログアウト"),
                                  message: Text("ログアウトしますか？"),
                                  primaryButton: .default(Text("いいえ")) {
                                    self.isShowLogoutAlert.toggle()
                                  },
                                  secondaryButton: .default(Text("はい")) {
                                    self.isShowLogoutAlert.toggle()
                                    AuthViewModel.authShared.logout()
                                  }
                            )
                        }
                    }.background(Color.white).cornerRadius(20)
                }
            }
        }
    }
    
    func profileButtonAction() {
        print("")
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
