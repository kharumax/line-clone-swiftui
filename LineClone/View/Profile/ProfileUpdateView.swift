//
//  ProfileUpdateView.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/25.
//

import SwiftUI

struct ProfileUpdateView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @Binding var isShowProfileEditView: Bool
    
    var body: some View {
        VStack {
            Text("Hello")
            Button(action: {
                self.isShowProfileEditView = false
            }, label: {
                Text("Click!! Here")
            })
        }
    }
}

//struct ProfileUpdateView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileUpdateView(isShowProfileEditView: .constant(true))
//    }
//}
