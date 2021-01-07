//
//  HomeView.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/20.
//

import SwiftUI
import KingfisherSwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel = HomeViewModel()
    let user = AuthViewModel.authShared.user
    
    func searchFriendUsers() {
        viewModel.searchFriendUsers()
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Group {
                        if user != nil {
                            KFImage(URL(string: user!.profileImageUrl))
                                .resizable()
                                .frame(width: 80,height: 80)
                                .cornerRadius(40)
                            Text(user!.username).font(.system(size: 32,weight: .semibold))
                            Spacer()
                        }
                    }
                }.padding(.bottom,24).padding(.top,16)
                HStack {
                    Text("友だち").foregroundColor(.gray).font(.system(size: 32,weight: .bold))
                    Spacer()
                }
                SearchBar(searchText: $viewModel.searchText, action: searchFriendUsers).padding(.vertical,8).disabled(viewModel.isShowModalView)
                ScrollView {
                    VStack {
                        ForEach(viewModel.friendUsers) { user in
                            Button(action: { viewModel.selectUser(user: user) }, label: {
                                FriendCell(user: user)
                            }).disabled(viewModel.isShowModalView)
                        }
                    }
                }
            }.padding(.horizontal,20).opacity(viewModel.isShowModalView ? 0.3 : 1)
            .onTapGesture(perform: {
                if viewModel.isShowModalView {
                    viewModel.releaseUser()
                }
            })
            if viewModel.isShowModalView && viewModel.selectedUser != nil && viewModel.roomId != nil {
                FriendModalView(user: viewModel.selectedUser!,roomId: viewModel.roomId!)
            }
        }
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}


/*
 
 VStack {
     HStack {
         Image("ironman")
             .resizable()
             .frame(width: 80,height: 80)
             .cornerRadius(40)
         Text("ironman").font(.system(size: 32,weight: .semibold))
         Spacer()
     }.padding(.bottom,24).padding(.top,16)
     HStack {
         Text("友だち").foregroundColor(.gray).font(.system(size: 32,weight: .bold))
         Spacer()
     }
     SearchBar(searchText: $searchText, action: test).padding(.vertical,8)
     ScrollView {
         VStack {
             ForEach(0..<20) { _ in
                 HStack {
                     FriendCell()
                 }
             }
         }
     }
 }.padding(.horizontal,20)
 
 
 */
