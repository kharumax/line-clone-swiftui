//
//  AuthViewModel.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/21.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    
    @Published var session: FirebaseAuth.User?
    @Published var email = ""
    @Published var password = ""
    @Published var username = ""
    @Published var selectedImage: UIImage?
    @Published var error: Error?
    @Published var errorMessage: String?
    @Published var isLoading = false
    @Published var user: User?
    
    static let authShared = AuthViewModel()
    
    init() {
        session = Auth.auth().currentUser
        fetchUser()
    }
    
    func fetchUser() {
        guard let uid = session?.uid else { return }
        self.isLoading = true
        AuthService.fetchUser(uid: uid) { (user, error) in
            self.isLoading = false
            if let error = error {
                self.error = error
                self.errorMessage = "ロードに失敗しました。"
                return
            }
            self.user = user
        }
    }
    
    func login() {
        self.isLoading = true
        AuthService.login(email: email, password: password) { (errorMsg, error) in
            if let error = error {
                self.error = error
                self.errorMessage = errorMsg
                self.isLoading = false
                return
            }
            self.fetchUser()
        }
    }
    
    func signUp() {
        
    }
    
}
