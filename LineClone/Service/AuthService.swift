//
//  AuthService.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/21.
//

import SwiftUI
import Firebase


struct AuthService {
    
    
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
    
    static func login(email: String,password: String,completion: @escaping(String?,Error?,FirebaseAuth.User?)-> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                if let code = AuthErrorCode(rawValue: error._code) {
                    switch code {
                        case .invalidEmail:
                            completion("メールアドレスの形式が違います。",error,nil)
                        case .emailAlreadyInUse:
                             completion("そのユーザーは既に存在しています。",error,nil)
                        case .weakPassword:
                             completion("パスワードは６文字以上です。",error,nil)
                        default:
                             completion("エラーが発生しました。再度、お試しださい。",error,nil)
                        }
                    return
                }
            }
            completion(nil,nil,result?.user)
        }
    }

    static func signUp(email: String,password: String,username: String,profileImage: UIImage,completion: @escaping(LineClone.User?,FirebaseAuth.User?,Error?,String?) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            // Authenticationでユーザー作成
            if let error = error {
                if let code = AuthErrorCode(rawValue: error._code) {
                    switch code {
                        case .invalidEmail:
                            completion(nil,nil,error,"メールアドレスの形式が違います。")
                        case .emailAlreadyInUse:
                            completion(nil,nil,error,"そのユーザーは既に存在しています。")
                        case .weakPassword:
                            completion(nil,nil,error,"パスワードは６文字以上です。")
                        default:
                            completion(nil,nil,error,"エラーが発生しました。再度、お試しださい。")
                    }
                    return
                }
            }
            // 画像を取り込む処理を行う
            guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else { return }
            let filename = "\(result?.user.uid)_\(NSUUID().uuidString)"
            let storageRef = STORAGE_USERS.child(filename)
            storageRef.putData(imageData, metadata: nil) { (_, error) in
                if let error = error {
                    completion(nil,nil,error,"画像をアップロードできませんでした。")
                    return
                }
                // 画像URLを取得する
                storageRef.downloadURL { (url, error) in
                    if let error = error {
                        completion(nil,nil,error,"画像をアップロードできませんでした。")
                        return
                    }
                    guard let profileImageUrl = url?.absoluteString else { return }
                    // 登録したユーザーのデータをDBに保存する
                    let data = ["uid": result?.user.uid,"email": email,"username": username,"bio": "","profileImageUrl": profileImageUrl] as [String: Any]
                    COLLECTION_USERS.document((result?.user.uid)!).setData(data) { (error) in
                        if let error = error {
                            completion(nil,nil,error,"エラーが発生しました。")
                            return
                        }
                        let user = User(dictionary: data)
                        completion(user,result?.user,nil,nil)
                    }
                    
                }
            }
            
           
        }
        
    }
    
    
    
}
