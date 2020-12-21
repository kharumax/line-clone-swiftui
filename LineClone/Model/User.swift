//
//  User.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/21.
//

import Foundation
import Firebase

struct User: Identifiable {
    // データ更新の際に特定することが出来るためにIdentifiableを継承する
    let id: String
    let email: String
    let username: String
    let profileImageUrl: String
    let bio: String?
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["uid"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.bio = dictionary["bio"] as? String ?? ""
    }
    
}
