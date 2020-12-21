//
//  User.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/21.
//

import Foundation

struct User {
    let uid: String
    let email: String
    let username: String
    let profileImageUrl: String
    let bio: String?
    
    init(dictionary: [String: Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.bio = dictionary["bio"] as? String ?? ""
    }
    
}
