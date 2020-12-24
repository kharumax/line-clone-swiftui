//
//  ProfileActionButton.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/24.
//

import SwiftUI

struct ProfileActionButton: View {
    
    var isCurrentUser = false
    var isFriendUser = true
    
    func buttonText() -> String {
        if isCurrentUser {
            return "プロフィールを設定"
        } else if isFriendUser {
            return "トークを開始"
        } else {
            return "友達追加する"
        }
    }
    
    var body: some View {
        HStack {
            Button(action: {}, label: {
                Text(buttonText())
                    .foregroundColor(.white)
                    .font(.system(size: 20,weight: .semibold))
            }).padding()
        }
        .background(Color.green)
        .cornerRadius(20)
    }
}

struct ProfileActionButton_Previews: PreviewProvider {
    static var previews: some View {
        ProfileActionButton()
    }
}
