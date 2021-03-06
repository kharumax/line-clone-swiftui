//
//  MainTabView.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/20.
//

import SwiftUI

struct MainTabView: View {
    @Binding var selectedIndex: Int
    @EnvironmentObject var viewModel: AuthViewModel
    
    // MARK: -- ProfileViewはログイン中のUserで初期化する
    var body: some View {
            TabView(selection: $selectedIndex) {
                HomeView()
                    .onTapGesture {
                        selectedIndex = 0
                    }
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("ホーム")
                    }.tag(0)
                SearchView()
                    .onTapGesture {
                        selectedIndex = 1
                    }
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("検索")
                    }.tag(1)
                ChatView()
                    .onTapGesture {
                        selectedIndex = 2
                    }
                    .tabItem {
                        Image(systemName: "message.fill")
                        Text("トーク")
                    }.tag(2)
                TimelineView()
                    .onTapGesture {
                        selectedIndex = 3
                    }
                    .tabItem {
                        Image(systemName: "clock.fill")
                        Text("タイムライン")
                    }.tag(3)
                Group {
                    if viewModel.user != nil {
                        ProfileView(user: viewModel.user!)
                            .onTapGesture {
                                selectedIndex = 4
                            }
                            .tabItem {
                                Image(systemName: "person.fill")
                                Text("プロフィール")
                            }.tag(4)
                    }
                }
            }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(selectedIndex: .constant(0))
    }
}
