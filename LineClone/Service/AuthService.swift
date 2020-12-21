//
//  AuthService.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/21.
//

import Foundation
import Firebase


struct AuthService {
    
    static func login(email: String,password: String,completion: @escaping(String?,Error?)-> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                if let code = AuthErrorCode(rawValue: error._code) {
                    switch code {
                        case .invalidEmail:
                            completion("メールアドレスの形式が違います。",error)
                        case .emailAlreadyInUse:
                            completion("そのユーザーは既に存在しています。",error)
                        case .weakPassword:
                            completion("パスワードは６文字以上です。",error)
                        default:
                            completion("エラーが発生しました。再度、お試しださい。",error)
                        }
                    return
                }
            } else {
                completion("",nil)
            }
        }
    }
    
    static func fetchUser(uid: String,completion: @escaping(User?,Error?)->Void) {
        let usersRef = COLLECTION_USERS.document(uid)
        usersRef.getDocument { (snapshot, error) in
            if let error = error {
                completion(nil,error)
                return
            }
            guard let data = snapshot?.data() else { return }
            let user = User(dictionary: data)
            completion(user,nil)
        }
    }
    
    
}
