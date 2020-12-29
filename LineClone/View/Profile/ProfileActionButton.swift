//
//  ProfileActionButton.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/24.
//

import SwiftUI

struct ProfileActionButton: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    // MARK: -- @Bindingだと真偽値がうまく動作しない。。。。
//    @Binding var isCurrentUser: Bool
//    @Binding var isFriendUser: Bool
//    @Binding var isShowProfileEditView: Bool
    
    var body: some View {
        HStack {
            Group {
                if viewModel.isCurrentUser {
                    Button(action: {
                        viewModel.isShowProfileEditView.toggle()
                    }, label: {
                        Text("プロフィールを編集")
                            .foregroundColor(.white)
                            .font(.system(size: 20,weight: .semibold))
                    }).padding()
                    .fullScreenCover(isPresented: $viewModel.isShowProfileEditView) {
                        ProfileUpdateView(viewModel: viewModel)
                    }
                } else {
                    Button(action: {
                        
                    }, label: {
                        Text(viewModel.isFriendUser ? "トークする" : "友達追加する")
                            .foregroundColor(.white)
                            .font(.system(size: 20,weight: .semibold))
                    }).padding()
                }
            }
        }
        .background(Color.green)
        .cornerRadius(20)
        
    }
}

//struct ProfileActionButton_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileActionButton(isCurrentUser: .constant(false), isFriendUser: .constant(true),isShowProfileEditView: .constant(false))
//    }
//}
