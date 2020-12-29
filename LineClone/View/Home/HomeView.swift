//
//  HomeView.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/20.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        VStack {
            HStack {
                Image("ironman")
                    .resizable()
                    .frame(width: 50,height: 50)
                    .cornerRadius(25)
                Text("ironman")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
