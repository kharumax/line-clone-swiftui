//
//  HomeViewModel.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/31.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var searchText = ""
    @Published var isShowModalView = false
    @Published var selectedUser: User?
    @Published var friendUsers = [User]()
    @Published var error: Error?
    let currentUid = AuthViewModel.authShared.session?.uid
    
    init() {
        self.fetchFriendUsers()
    }
    
    func fetchFriendUsers() {
        guard let currentUid = self.currentUid else { return }
        HomeService.fetchFriendUser(uid: currentUid) { (users, error) in
            if let error = error {
                self.error = error
                return
            }
            guard let users = users else { return }
            self.friendUsers = users
        }
    }
    
    func selectUser(user: User) {
        self.selectedUser = user
        self.isShowModalView = true
    }
    
    func releaseUser() {
        self.selectedUser = nil
        self.isShowModalView = false
    }
    
    func searchFriendUsers() {
        self.friendUsers = self.friendUsers.filter({$0.username.contains(searchText.lowercased())})
    }
    
}
