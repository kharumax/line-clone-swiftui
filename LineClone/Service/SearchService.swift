//
//  SearchService.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/24.
//

import SwiftUI
import Firebase

struct SearchService {
    
    static func fetchUsers(completion: @escaping([User]?,Error?) -> Void) {
        var users = [User]()
        COLLECTION_USERS.getDocuments { (snapshot, error) in
            if let error = error {
                completion(nil,error)
                return
            }
            guard let documents = snapshot?.documents else {
                completion(users,nil)
                return
            }
            users = documents.map({User(dictionary: $0.data())})
            completion(users,nil)
        }
    }
    
    // MARK: -- FireStoreでいい感じのor検索をする方法が見つかれば実装
    static func searchUsers(searchText: String) {
        
    }
    
}
