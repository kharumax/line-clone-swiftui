//
//  SignUpView.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/21.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State var isShowImagePicker = false
    @State var image: Image?
    
    var isFormValid: Bool {
        return !(viewModel.email.isEmpty || viewModel.password.count < 6 ||
                    viewModel.username.isEmpty || viewModel.selectedImage == nil)
    }
    
    @Binding var isShowLoginView: Bool
    
    func loadImage() {
        guard let selectedImage = viewModel.selectedImage else { return }
        image = Image(uiImage: selectedImage)
    }
        
    var body: some View {
            VStack {
                Button(action: { self.isShowImagePicker.toggle() }, label: {
                    ZStack {
                        if let image = image {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 200,height: 200)
                                .cornerRadius(100)
                                .padding(.bottom,16)
                        } else {
                            Image(systemName: "person.circle")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 200,height: 200)
                                .padding(.bottom,16)
                                .foregroundColor(.green)
                        }
                    }
                }).sheet(isPresented: $isShowImagePicker, onDismiss: loadImage, content: {
                    ImagePicker(image: $viewModel.selectedImage)
                })
                    
                VStack(spacing: 10) {
                    ZStack {
                        HStack {
                            Image(systemName: "person")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20,height: 20)
                            TextField("Username",text: $viewModel.username)
                        }.padding()
                    }
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1))
                    ZStack {
                        HStack {
                            Image(systemName: "envelope")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20,height: 20)
                            TextField("Email",text: $viewModel.email)
                        }.padding()
                    }
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1))
                    ZStack {
                        HStack {
                            Image(systemName: "lock")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20,height: 20)
                            SecureField("Password",text: $viewModel.password)
                        }.padding()
                    }
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1))
                }.padding(.horizontal,50).padding(.bottom,50)
                VStack {
                    Button(action: {}, label: {
                        ZStack {
                            Text("会員登録").foregroundColor(.white)
                                .padding()
                        }
                        .background(Color.green)
                        .cornerRadius(20)
                    })
                }
                Spacer()
                VStack {
                    Button(action: {
                        self.isShowLoginView = false
                    }, label: {
                        ZStack {
                            Text("ログインはこちら")
                                .foregroundColor(.green)
                                .padding()
                        }
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 1).fill(Color.black))
                    })
                }
                Spacer()
            }.padding(.top,80)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(isShowLoginView: .constant(true))
    }
}
