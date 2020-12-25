//
//  ContentView.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/20.
//

import SwiftUI
import KingfisherSwiftUI

func getTitle(forIndex: Int) -> String {
    if forIndex == 0 {
        return "ホーム"
    } else if forIndex == 1 {
        return "検索"
    } else if forIndex == 2 {
        return "トーク"
    } else if forIndex == 3{
        return "タイムライン"
    } else {
        return "プロフィール"
    }
}

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State var selectedIndex = 0
    
    var body: some View {
        Group {
            if viewModel.session != nil {
                Group {
                    if viewModel.isLoading {
                        
                    } else {
                        NavigationView {
                            MainTabView(selectedIndex: $selectedIndex)
                                .padding(.top,8)
                                .navigationTitle(getTitle(forIndex: selectedIndex))
                                .navigationBarTitleDisplayMode(.inline)
                                .navigationBarItems(leading: Button(action: {}, label: {
                                    HStack {
                                        KFImage(URL(string: viewModel.user!.profileImageUrl))
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 30,height: 30)
                                            .cornerRadius(15)
                                            .clipped()
                                    }
                                }))
                        }
                    }
                }
            } else {
                LoginView()
            }
        }
    }
}

// UI確認用
//Group {
//        NavigationView {
//            MainTabView(selectedIndex: $selectedIndex)
//                .padding(.top,8)
//                .navigationTitle(getTitle(forIndex: selectedIndex))
//                .navigationBarTitleDisplayMode(.inline)
//                .navigationBarItems(leading: Button(action: {}, label: {
//                    HStack {
//                        Image("ironman")
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: 30,height: 30)
//                            .cornerRadius(15)
//                            .clipped()
//                    }
//                }))
//        }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            //.environmentObject(AuthViewModel.authShared)
    }
}
