//
//  ContentView.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/20.
//

import SwiftUI

func getTitle(forIndex: Int) -> String {
    if forIndex == 0 {
        return "ホーム"
    } else if forIndex == 1 {
        return "検索"
    } else if forIndex == 2 {
        return "トーク"
    } else {
        return "タイムライン"
    }
}


struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State var selectedIndex = 0
    
    var body: some View {
        Group {
            if viewModel.session != nil {
                NavigationView {
                    MainTabView(selectedIndex: $selectedIndex)
                        .navigationBarTitle(getTitle(forIndex: selectedIndex))
                        .navigationBarTitleDisplayMode(.inline)
                }
            } else {
                LoginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
