//
//  ProfileView.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/23.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            Image("ironman")
                .resizable()
                .scaledToFill()
                .frame(width: 250,height: 250)
                .cornerRadius(125)
                .clipped()
                .padding(.bottom,24)
            Text("Ironman").font(.system(size: 20,weight: .semibold))
                .padding(.bottom,16)
            Text("I am ironman . Also I am Tony Stark, It's means that I am CEO of Stark Industory").font(.system(size: 16)).lineLimit(5).padding(.horizontal,40)
                .padding(.bottom,24)
            ProfileActionButton()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
