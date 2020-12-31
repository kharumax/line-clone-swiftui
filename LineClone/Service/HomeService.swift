//
//  HomeService.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/31.
//

import SwiftUI
import Firebase


struct HomeService {
    
    static func fetchFriendUser(uid: String,completion: @escaping([User]?,Error?) -> Void) {
        COLLECTION_USERS_FRIENDS(uid: uid).getDocuments { (snapshot, error) in
            if let error = error {
                completion(nil,error)
                return
            }
            guard let documents = snapshot?.documents else {
                completion(nil,nil)
                return
            }
            // ここでユーザーのID一覧を取得する
            let friendIds = documents.map({ $0.documentID }) as Array<String>
            SearchService.fetchUsers { (users, error) in
                if let error = error {
                    completion(nil,error)
                    return
                }
                guard var users = users else {
                    completion(nil,nil)
                    return
                }
                users = users.filter({ friendIds.firstIndex(of: $0.id) != nil })
                completion(users,nil)
            }
        }
    }
    
    
}
