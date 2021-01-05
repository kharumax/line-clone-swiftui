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
    @ObservedObject var viewModel: TimelineCellViewModel
    
    init(timeline: Timeline) {
        self.timeline = timeline
        self.viewModel = TimelineCellViewModel(timeline: timeline)
    }
    
    func clearCommentText() {
        viewModel.text = ""
    }
    
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
                Button(action: {
                    viewModel.isLiked ? viewModel.unlike() : viewModel.like()
                }, label: {
                    Image(systemName: viewModel.isLiked ? "heart.fill" : "heart")
                        .frame(width: 32,height: 32)
                        .foregroundColor(viewModel.isLiked ? .red : .black)
                })
                Text("\(viewModel.likesCount)")
                Button(action: { viewModel.isShowCommentView.toggle() }, label: {
                    Image(systemName: "bubble.right")
                        .frame(width: 32,height: 32).foregroundColor(.black)
                })
                .sheet(isPresented: $viewModel.isShowCommentView,onDismiss: clearCommentText ,content: {
                    // viewModelを渡す
                    CommentView(viewModel: viewModel)
                })
                Text("\(viewModel.commentsCount)")
                Button(action: {}, label: {
                    Image(systemName: "square.and.arrow.up")
                        .frame(width: 32,height: 32).foregroundColor(.black)
                }).padding(.bottom,4)
                Spacer()
            }.padding(.leading,8)
            HStack {
                Text("\(viewModel.formatTimestamp())")
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
