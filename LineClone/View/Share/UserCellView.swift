//
//  UserCellView.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/23.
//

import SwiftUI

struct UserCellView: View {
    var body: some View {
        HStack(spacing: 20) {
            Image("ironman")
                .resizable()
                .scaledToFill()
                .frame(width: 100,height: 100)
                .cornerRadius(50)
                .clipped()
            VStack(alignment: .leading,spacing: 10) {
                Text("Ironman").font(.system(size: 20,weight: .semibold))
                Text("I am Ironman .").font(.system(size: 16))
            }
            Spacer()
        }.padding(.horizontal,16)
    }
}

struct UserCellView_Previews: PreviewProvider {
    static var previews: some View {
        UserCellView()
    }
}
