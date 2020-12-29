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
func COLLECTION_USERS_FRIENDS(uid: String) -> CollectionReference {
    return COLLECTION_USERS.document(uid).collection("friends")
}
let COLLECTION_ROOMS = Firestore.firestore().collection("rooms")
func COLLECTION_USERS_ROOMS(uid: String) -> CollectionReference {
    return COLLECTION_USERS.document(uid).collection("rooms")
}

/*
 
ホームページ
 →友達ユーザーを一覧で並べる
 　→クリックして、モーダルを表示する
 　　→プロフィールか、チャットか
 　　　→プロフィールの場合はそのまま、ユーザーを渡して遷移する
 　　　　→ユーザーIDからルームID〜〜〜
 　　　→チャットの場合は、ルームの中から相手のユーザーIDのルームIDを取得して、
 　　　　ルームの情報を渡して遷移する
 

 
 */



