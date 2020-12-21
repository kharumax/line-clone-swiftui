//
//  LoginView.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/21.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    
    @State var isShowSignUpView = false
    
    var body: some View {
        NavigationView {
            VStack {
                Image("line_logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 220,height: 120)
                    .padding()
                    .padding(.bottom,80)
                    
                VStack(spacing: 10) {
                    ZStack {
                        HStack {
                            Image(systemName: "envelope")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20,height: 20)
                            TextField("Email",text: $email)
                        }.padding()
                    }
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1))
                    ZStack {
                        HStack {
                            Image(systemName: "lock")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20,height: 20)
                            TextField("Password",text: $password)
                        }.padding()
                    }
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1))
                }.padding(.horizontal,50).padding(.bottom,50)
                VStack {
                    Button(action: {}, label: {
                        ZStack {
                            Text("ログイン").foregroundColor(.white)
                                .padding()
                        }
                        .background(Color.green)
                        .cornerRadius(20)
                    })
                }
                Spacer()
                VStack {
                    NavigationLink(
                        destination: SignUpView(isShowLoginView: $isShowSignUpView).navigationBarHidden(true),
                        isActive: $isShowSignUpView,
                        label: {
                            Button(action: {
                                self.isShowSignUpView = true
                            }, label: {
                                ZStack {
                                    Text("会員登録はこちら")
                                        .foregroundColor(.green)
                                        .padding()
                                }
                                .overlay(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 1).fill(Color.black))
                            })
                        })
                    Button(action: {}, label: {
                        ZStack {
                            Text("パスワードをお忘れですか？")
                                .foregroundColor(.green)
                                .padding()
                        }
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 1).fill(Color.black))
                    })
                }
                Spacer()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
