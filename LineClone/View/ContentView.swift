//
//  ContentView.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/20.
//

import SwiftUI

func getTitle(forIndex: Int) -> String {
    if forIndex == 0 {
        return "Home"
    } else if forIndex == 1 {
        return "Talk"
    } else {
        return "Timeline"
    }
}


struct ContentView: View {
    @State var selectedIndex = 0
    
    var body: some View {
        Group {
            NavigationView {
                MainTabView(selectedIndex: $selectedIndex)
                    .navigationBarTitle(getTitle(forIndex: selectedIndex))
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
