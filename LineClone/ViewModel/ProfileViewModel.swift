//
//  ProfileViewModel.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/24.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    
    @Published var user: User
    @Published var isCurrentUser: Bool
    @Published var isFriendUser = false
    @Published var isEditProfile = false
    @Published var error: Error?
    private let currentUid = AuthViewModel.authShared.session!.uid // user in LoggedIn
    
    init(user: User) {
        self.user = user
        self.isCurrentUser = self.currentUid == user.id
        self.IsFriendUser()
    }
    
    func IsFriendUser() {
        ProfileService.IsFriendUser(currentUid: currentUid, uid: user.id) { (isFriendUser, error) in
            if let error = error {
                self.error = error
                return
            }
            self.isFriendUser = isFriendUser!
        }
    }
    
    func addFriend() {
        ProfileService.addFriend(currentUid: currentUid, uid: user.id) { error in
            if let error = error {
                self.error = error
                return
            }
            self.isFriendUser = true
        }
    }
    
}
