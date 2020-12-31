//
//  CommentCellView.swift
//  LineClone
//
//  Created by 久保田陽人 on 2021/01/01.
//

import SwiftUI
import KingfisherSwiftUI

struct CommentCellView: View {
    var body: some View {
        HStack(alignment: .top) {
            Image("ironman")
                .resizable()
                .scaledToFill()
                .frame(width: 32,height: 32)
                .cornerRadius(16)
                .padding(.top,2)
            VStack(alignment: .leading) {
                Text("ironman").font(.system(size: 18))
                Text("Yes i think so ...")
            }
            Spacer()
        }.padding(.horizontal,8)
    }
}

struct CommentCellView_Previews: PreviewProvider {
    static var previews: some View {
        CommentCellView()
    }
}
