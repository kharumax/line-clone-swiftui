//
//  TimelineService.swift
//  LineClone
//
//  Created by 久保田陽人 on 2021/01/01.
//

import SwiftUI

struct TimelineService {
    
    // MARK: -- Used in TimelineViewModel
    static func fetchTimelines(completion: @escaping([Timeline]?,Error?) -> Void) {
        COLLECTION_TIMELINES.getDocuments { (snapshot, error) in
            if let error = error {
                completion(nil,error)
                return
            }
            guard let documents = snapshot?.documents else {
                completion(nil,nil)
                return
            }
            let timelines = documents.map({ Timeline(dictionary: $0.data()) })
            completion(timelines,nil)
        }
    }
    
    static func postTimeline(user: User,caption: String,image: UIImage,completion: @escaping(Timeline?,Error?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.3) else {
            completion(nil,nil)
            return
        }
        let timelinesRef = COLLECTION_TIMELINES.document()
        let filename = "\(timelinesRef.documentID)_\(NSUUID().uuidString)"
        let storageRef = STORAGE_TIMELINE.child(filename)
        storageRef.putData(imageData,metadata: nil) { (_, error) in
            if let error = error {
                completion(nil,error)
                return
            }
            storageRef.downloadURL { (url, error) in
                if let error = error {
                    completion(nil,error)
                    return
                }
                guard let imageUrl = url?.absoluteString else {
                    completion(nil,nil)
                    return
                }
                let timelineData = initTimeline(id: timelinesRef.documentID, user: user, caption: caption, imageUrl: imageUrl)
                timelinesRef.setData(timelineData) { (error) in
                    if let error = error {
                        completion(nil,error)
                        return
                    }
                    let timeline = Timeline(dictionary: timelineData)
                    completion(timeline,nil)
                }
            }
        }
    }
    // MARK: -- Used in TimelineCellViewModel
    
    static func checkIsLiked(userId: String,timelineId: String,completion: @escaping(Bool?,Error?) -> Void) {
        let likedRef = COLLECTION_USER_LIKES(uid: userId).document(timelineId)
        likedRef.getDocument { (snapshot, error) in
            if let error = error {
                completion(nil,error)
                return
            }
            guard let snapshot = snapshot else {
                completion(nil,nil)
                return
            }
            completion(snapshot.exists,nil)
        }
    }
    
    static func like(userId: String,timelineId: String,completion: @escaping(Error?) -> Void) {
        let userRef = COLLECTION_USER_LIKES(uid: userId)
        let timelineRef = COLLECTION_TIMELINE_LIKES(timelineId: timelineId)
        let data = ["status": true]
        timelineRef.document(userId).setData(data) { (error) in
            if let error = error {
                completion(error)
                return
            }
            userRef.document(timelineId).setData(data) { (error) in
                if let error = error {
                    completion(error)
                    return
                }
                completion(nil)
            }
        }
    }
    
    static func unlike(userId: String,timelineId: String,completion: @escaping(Error?) -> Void) {
        let userRef = COLLECTION_USER_LIKES(uid: userId)
        let timelineRef = COLLECTION_TIMELINE_LIKES(timelineId: timelineId)
        timelineRef.document(userId).delete { (error) in
            if let error = error {
                completion(error)
                return
            }
            userRef.document(timelineId).delete { (error) in
                if let error = error {
                    completion(error)
                    return
                }
                completion(nil)
            }
        }
    }
    
    static func fetchLikes(timelineId: String,completion: @escaping(Int?,Error?) -> Void) {
        let timelineRef = COLLECTION_TIMELINE_LIKES(timelineId: timelineId)
        timelineRef.getDocuments { (snapshot, error) in
            if let error = error {
                completion(nil,error)
                return
            }
            guard let documents = snapshot?.documents else {
                completion(0,nil)
                return
            }
            completion(documents.count,nil)
        }
    }
    
    static func fetchComments(timelineId: String,completion: @escaping([Comment]?,Error?) -> Void) {
        let timelineRef = COLLECTION_TIMELINE_COMMENTS(timelineId: timelineId)
        var comments = [Comment]()
        timelineRef.getDocuments { (snapshot, error) in
            if let error = error {
                completion(nil,error)
                return
            }
            guard let documents = snapshot?.documents else {
                completion(comments,nil)
                return
            }
            comments = documents.map({ Comment(dictionary: $0.data()) })
            completion(comments,nil)
        }
    }
    
    static func postComment(timelineId: String,user: User,text: String,completion: @escaping(Comment?,Error?) -> Void) {
        let timelineRef = COLLECTION_TIMELINE_COMMENTS(timelineId: timelineId).document()
        let data = initComment(id: timelineRef.documentID, user: user, text: text)
        timelineRef.setData(data) { (error) in
            if let error = error {
                completion(nil,error)
                return
            }
            let comment = Comment(dictionary: data)
            completion(comment,nil)
        }
    }
    
}
