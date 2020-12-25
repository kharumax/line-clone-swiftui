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
        print("DEBUG: AuthViewModel is init!")
        self.isLoading = true
        session = Auth.auth().currentUser
        fetchUser()
    }
    
    func fetchUser() {
        self.isLoading = true
        guard let uid = session?.uid else { return }
        AuthService.fetchUser(uid: uid) { (user, error) in
            print("DEBUG: AuthViewModel fetchUser is called!")
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
        AuthService.login(email: email, password: password) { (errorMsg, error, session) in
            if let error = error {
                self.error = error
                self.errorMessage = errorMsg
                self.isLoading = false
                print("DEBUG: Error is \(self.errorMessage?.debugDescription) at AuthViewModel")
                return
            }
            self.session = session
            self.fetchUser()
        }
    }
    
    func signUp() {
        self.isLoading = true
        AuthService.signUp(email: email, password: password, username: username, profileImage: selectedImage!) { (user, session, error, errorMsg) in
            if let error = error {
                self.isLoading = false
                self.error = error
                self.errorMessage = errorMsg
                print("DEBUG: Error is \(self.errorMessage?.debugDescription) at AuthViewModel")
                return
            }
            self.session = session
            self.user = user
        }
    }
    
}
