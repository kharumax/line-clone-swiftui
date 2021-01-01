//
//  PostTimelineView.swift
//  LineClone
//
//  Created by 久保田陽人 on 2021/01/01.
//

import SwiftUI

struct PostTimelineView: View {
    
    @Binding var isShowPostTimelineView: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Button(action: {
                    self.isShowPostTimelineView.toggle()
                }, label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 24,height: 24)
                        .foregroundColor(.gray).padding()
                })
                Spacer()
                Button(action: {}, label: {
                    Text("投稿").font(.system(size: 20,weight: .semibold))
                        .foregroundColor(.gray).padding()
                })
            }.padding(.top,16).padding(.bottom,24).padding(.horizontal,16)
            HStack {
                Image("ironman")
                    .resizable()
                    .frame(width: 50,height: 50)
                    .cornerRadius(25)
                Text("ironman").font(.system(size: 24,weight: .semibold))
                Spacer()
            }.padding(.leading,8)
            Image(systemName: "photo.fill")
                .resizable()
                .scaledToFit()
                .background(Color.white)
            HStack {
                Text("I am ironman ... ")
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.horizontal).padding(.top)
            }
            Spacer()
        }
    }
}

struct PostTimelineView_Previews: PreviewProvider {
    static var previews: some View {
        PostTimelineView(isShowPostTimelineView: .constant(true))
    }
}
