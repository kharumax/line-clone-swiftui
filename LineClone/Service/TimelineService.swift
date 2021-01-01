//
//  TimelineService.swift
//  LineClone
//
//  Created by 久保田陽人 on 2021/01/01.
//

import SwiftUI

struct TimelineService {
    
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
    
}
