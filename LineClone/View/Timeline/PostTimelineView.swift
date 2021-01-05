//
//  PostTimelineView.swift
//  LineClone
//
//  Created by 久保田陽人 on 2021/01/01.
//

import SwiftUI
import KingfisherSwiftUI

struct PostTimelineView: View {
    
    @ObservedObject var viewModel: TimelineViewModel
    @State var isShowImagePicker = false
    @State var image: Image?
    
    func loadImage() {
        guard let selectedImage = viewModel.selectedImage else { return }
        image = Image(uiImage: selectedImage)
    }
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Button(action: {
                    viewModel.isShowPostTimelineView.toggle()
                }, label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 24,height: 24)
                        .foregroundColor(.gray).padding()
                })
                Spacer()
                Button(action: {
                    viewModel.postTimeline()
                }, label: {
                    Text("投稿").font(.system(size: 20,weight: .semibold))
                        .foregroundColor(viewModel.isPostValid ? .green : .gray).padding()
                }).disabled(!viewModel.isPostValid)
            }.padding(.top,16).padding(.bottom,24).padding(.horizontal,16)
            HStack {
                KFImage(URL(string: viewModel.user.profileImageUrl))
                    .resizable()
                    .frame(width: 50,height: 50)
                    .cornerRadius(25)
                Text(viewModel.user.username).font(.system(size: 24,weight: .semibold))
                Spacer()
            }.padding(.leading,8)
            Button(action: { self.isShowImagePicker.toggle() }, label: {
                ZStack {
                    if let image = image {
                        image
                            .resizable()
                            .scaledToFit()
                            .background(Color.white)
                    } else {
                        Image(systemName: "photo.fill")
                            .resizable()
                            .scaledToFit()
                            .background(Color.white)
                    }
                }
            }).sheet(isPresented: $isShowImagePicker, onDismiss: loadImage, content: {
                ImagePicker(image: $viewModel.selectedImage)
            })
            
            HStack {
                TextField("What's Up?", text: $viewModel.caption)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.horizontal).padding(.top)
            }
            Spacer()
        }
    }
}

//struct PostTimelineView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostTimelineView(isShowPostTimelineView: .constant(true))
//    }
//}
