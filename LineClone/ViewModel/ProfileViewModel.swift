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
    //@Published var isEditProfile = false
    @Published var isShowProfileEditView = false
    @Published var error: Error?
    @Published var username: String
    @Published var bio: String
    @Published var selectedImage: UIImage?
    private let currentUid = AuthViewModel.authShared.session?.uid // user in LoggedIn
    
    init(user: User) {
        print("DEBUG: ProfileViewModel is init")
        print("DEBUG: self.currentUid == user.id is \(self.currentUid == user.id)")
        self.user = user
        self.isCurrentUser = self.currentUid == user.id
        self.username = user.username
        self.bio = user.bio ?? ""
        self.IsFriendUser()
    }
    
    func IsFriendUser() {
        guard let currentUid = self.currentUid else { return }
        ProfileService.IsFriendUser(currentUid: currentUid, uid: user.id) { (isFriendUser, error) in
            if let error = error {
                print("DEBUG: IsFriendUser is error")
                self.error = error
                return
            }
            print("DEBUG: IsFriendUser , value is \(isFriendUser.debugDescription)")
            self.isFriendUser = isFriendUser!
        }
    }
    
    func addFriend() {
        guard let currentUid = self.currentUid else { return }
        ProfileService.addFriend(currentUid: currentUid, uid: user.id) { error in
            if let error = error {
                self.error = error
                return
            }
            self.isFriendUser = true
        }
    }
    
    func updateProfile() {
        guard let currentUid = self.currentUid else { return }
        if selectedImage != nil {
            ProfileService.updateProfileImage(currentUid: currentUid, image: selectedImage) { (url, error) in
                if let error = error {
                    self.error = error
                    return
                }
                guard let profileImageUrl = url else { return }
                ProfileService.updateProfile(user: self.user, username: self.username, bio: self.bio, imageUrl: profileImageUrl) { (user, error) in
                    if let error = error {
                        self.error = error
                        return
                    }
                    self.user = user!
                    self.isShowProfileEditView.toggle()
                }
            }
        } else {
            ProfileService.updateProfile(user: self.user, username: self.username, bio: self.bio, imageUrl: self.user.profileImageUrl) { (user, error) in
                if let error = error {
                    self.error = error
                    return
                }
                self.user = user!
                self.isShowProfileEditView.toggle()
            }
        }
    }
    
    func startChat() {
        // 既に部屋が存在しているかどうかを判断する
        // 存在している場合はそこに遷移する。存在しない場合は部屋を作成して、遷移する
    }
    
}
