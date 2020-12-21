//
//  LoginView.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/21.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State var isShowSignUpView = false
     
    var isFormValid: Bool {
        return !(viewModel.email.isEmpty || viewModel.password.count < 6)
    }
    
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
                    Button(action: {
                        viewModel.login()
                    }, label: {
                        ZStack {
                            Text("ログイン").foregroundColor(.white)
                                .padding()
                        }
                        .background(isFormValid ? Color.green : Color.green.opacity(0.5))
                        .cornerRadius(20)
                    }).disabled(!isFormValid)
                }
                Spacer()
                VStack(spacing: 10) {
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
