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
    
    init(user: User) {
        self.user = user
        self.viewModel = ProfileViewModel(user: user)
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
