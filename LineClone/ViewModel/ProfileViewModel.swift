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
    @Published var isShowProfileEditView = false
    @Published var error: Error?
    @Published var username: String
    @Published var bio: String
    @Published var selectedImage: UIImage?
    @Published var roomId: String?
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
                self.error = error
                return
            }
            print("DEBUG: isFriendUser is \(isFriendUser) / ProfileViewModel")
            guard let isFriendUser = isFriendUser else { return }
            self.isFriendUser = isFriendUser
            self.getRoomInfo()
        }
    }
    
    func addFriend() {
        if !isFriendUser {
            guard let currentUid = self.currentUid else { return }
            ProfileService.addFriend(currentUid: currentUid, uid: user.id) { error in
                if let error = error {
                    self.error = error
                    return
                }
                self.isFriendUser = true
                AuthService.fetchUser(uid: currentUid) { (sender, error) in
                    if let error = error {
                        self.error = error
                        return
                    }
                    guard let sender = sender else { return }
                    ProfileService.createChatRoom(sender: sender, receiver: self.user) { (error) in
                        if let error = error {
                            self.error = error
                            return
                        }
                        self.getRoomInfo()
                    }
                }
            }
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
    
    func getRoomInfo() {
        // トークルームの情報を取得して、Viewを移動する
        //guard isFriendUser == true && isCurrentUser == false else { return }
        print("DEBUG: isCurrentUser is \(isCurrentUser) / ProfileViewModel / getRoomInfo")
        print("DEBUG: isFriendUser is \(isFriendUser) / ProfileViewModel / getRoomInfo")
        if !isCurrentUser && isFriendUser {
            guard let currentUid = currentUid else { return }
            print("DEBUG: getRoomInfo is called")
            ProfileService.getRoomId(currentUid: currentUid, userId: user.id) { (roomId, error) in
                if let error = error {
                    print("Error: Error is \(error.localizedDescription)")
                    return
                }
                guard let roomId = roomId else { return }
                self.roomId = roomId
            }
        }
    }
    
}
