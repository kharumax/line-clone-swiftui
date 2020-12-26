//
//  ProfileUpdateView.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/25.
//

import SwiftUI
import KingfisherSwiftUI

struct ProfileUpdateView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @State var isShowImagePicker = false
    @State var image: Image?
    
    func loadImage() {
        guard let selectedImage = viewModel.selectedImage else { return }
        image = Image(uiImage: selectedImage)
    }
    
    var body: some View {
        VStack {
            Button(action: { isShowImagePicker.toggle() }, label: {
                Group {
                    if let image = image {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 250,height: 250)
                            .cornerRadius(125)
                            .clipped()
                            .padding(.bottom,24)
                    } else {
                        KFImage(URL(string: viewModel.user.profileImageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 250,height: 250)
                            .cornerRadius(125)
                            .clipped()
                            .padding(.bottom,24)
                    }
                }
            }).sheet(isPresented: $isShowImagePicker, onDismiss: loadImage, content: {
                ImagePicker(image: $viewModel.selectedImage)
            })
            VStack(spacing: 10) {
                ZStack {
                    TextField(viewModel.username, text: $viewModel.username).font(.system(size: 20,weight: .semibold)).padding()
                }.overlay(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 1).fill(Color.gray)).padding(.bottom,40)
                ZStack {
                    TextField(viewModel.bio, text: $viewModel.bio).font(.system(size: 16)).lineLimit(5).padding()
                }.overlay(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 1).fill(Color.gray)).padding(.horizontal,40)
                .padding(.bottom,24)
                HStack(spacing: 10) {
                    Button(action: { viewModel.isShowProfileEditView.toggle() }, label: {
                        ZStack {
                            Text("キャンセル")
                                .foregroundColor(.green)
                                .font(.system(size: 16))
                                .padding()
                                .padding(.horizontal)
                        }
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 1).fill(Color.green))
                    })
                    Button(action: {
                        
                    }, label: {
                        ZStack {
                            Text("更新する").foregroundColor(.white)
                                .font(.system(size: 16, weight: .semibold))
                                .padding()
                                .padding(.horizontal)
                        }
                        .background(Color.green)
                        .cornerRadius(20)
                    })
                }
            }
            
        }
    }
}

//struct ProfileUpdateView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileUpdateView()
//    }
//}
