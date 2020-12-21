//
//  Constants.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/21.
//

import Foundation
import Firebase


// Storage Path

let STORAGE_USERS = Storage.storage().reference().child("profile_images")
let STORAGE_TIMELINE = Storage.storage().reference().child("timeline_images")


// Firestore Collection
let COLLECTION_USERS = Firestore.firestore().collection("users")
