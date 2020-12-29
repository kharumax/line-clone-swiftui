//
//  SearchViewModel.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/24.
//

import SwiftUI


class SearchViewModel: ObservableObject {
    
    @Published var users = [User]()
    @Published var error: Error?
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    // SearchViewでインスタンス化された時にデータ表示する
    init() {
        self.fetchUsers()
    }
    
    func fetchUsers() {
        self.isLoading = true
        SearchService.fetchUsers { (users, error) in
            self.isLoading = false
            if let error = error {
                self.error = error
                self.errorMessage = error.localizedDescription
            }
            guard let users = users else { return }
            self.users = users
        }
    }
    
    func searchUsers(searchText: String) {
        self.users = self.users.filter({$0.username.contains(searchText.lowercased())})
    }
    
}
