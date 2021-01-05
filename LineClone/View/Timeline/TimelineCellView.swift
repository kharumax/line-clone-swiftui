//
//  TimeLineCellView.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/31.
//

import SwiftUI
import KingfisherSwiftUI

struct TimelineCellView: View {
    
    let timeline: Timeline
    @State var isShowCommentView = false
    
    var body: some View {
        VStack {
            HStack {
                KFImage(URL(string: timeline.profileImageUrl))
                    .resizable()
                    .frame(width: 50,height: 50)
                    .cornerRadius(25)
                Text(timeline.username).font(.system(size: 24,weight: .semibold))
                Spacer()
            }.padding(.leading,8)
            KFImage(URL(string: timeline.imageUrl))
                .resizable()
                .scaledToFit()
            HStack {
                Text(timeline.caption)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.horizontal).padding(.top)
            }
            HStack {
                Button(action: {}, label: {
                    Image(systemName: "heart")
                        .frame(width: 32,height: 32)
                        .foregroundColor(.black)
                })
                Text("0")
                Button(action: { self.isShowCommentView.toggle() }, label: {
                    Image(systemName: "bubble.right")
                        .frame(width: 32,height: 32).foregroundColor(.black)
                })
                .sheet(isPresented: $isShowCommentView, content: {
                    CommentView()
                })
                Text("0")
                Button(action: {}, label: {
                    Image(systemName: "square.and.arrow.up")
                        .frame(width: 32,height: 32).foregroundColor(.black)
                }).padding(.bottom,4)
                Spacer()
            }.padding(.leading,8)
            HStack {
                Text("2020/12/31 12:54")
                Spacer()
            }.padding(.leading,16)
        }
    }
}



//struct TimeLineCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimelineCellView()
//    }
//}
