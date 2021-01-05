//
//  TimelineCellViewModel.swift
//  LineClone
//
//  Created by 久保田陽人 on 2021/01/05.
//

import SwiftUI

class TimelineCellViewModel: ObservableObject {
    
    let timeline: Timeline
    
    @Published var isLiked = false
    @Published var isShowCommentView = false
    @Published var comments = [Comment]()
    @Published var likesCount = 0
    @Published var commentsCount = 0
    @Published var text: String = ""
    let user = AuthViewModel.authShared.user!
    var isFormValid: Bool {
        return !text.isEmpty
    }
    
    init(timeline: Timeline) {
        self.timeline = timeline
        self.checkIsLiked()
        self.fetchLikes()
        self.fetchComments()
    }
    
    func formatTimestamp() -> String {
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "yyyy年MM年dd日: HH:mm"
        let dateString = dataFormatter.string(from: timeline.timestamp.dateValue())
        return dateString
    }
    
    func checkIsLiked() {
        TimelineService.checkIsLiked(userId: user.id, timelineId: timeline.id) { (isLiked, error) in
            if let error = error {
                print("DEBUG: Error is \(error.localizedDescription)")
                return
            }
            guard let isLiked = isLiked else { return }
            self.isLiked = isLiked
        }
    }
    
    func like() {
        TimelineService.like(userId: user.id, timelineId: timeline.id) { (error) in
            if let error = error {
                print("DEBUG: Error is \(error.localizedDescription)")
                return
            }
            self.isLiked = true
            self.likesCount += 1
        }
    }
    
    func unlike() {
        TimelineService.unlike(userId: user.id, timelineId: timeline.id) { (error) in
            if let error = error {
                print("DEBUG: Error is \(error.localizedDescription)")
                return
            }
            self.isLiked = false
            self.likesCount -= 1
        }
    }
    
    func fetchLikes() {
        TimelineService.fetchLikes(timelineId: timeline.id) { (likesCount, error) in
            if let error = error {
                print("DEBUG: Error is \(error.localizedDescription)")
                return
            }
            guard let likesCount = likesCount else { return }
            self.likesCount = likesCount
        }
    }
    
    func fetchComments() {
        TimelineService.fetchComments(timelineId: timeline.id) { (comments, error) in
            if let error = error {
                print("DEBUG: Error is \(error.localizedDescription)")
                return
            }
            guard let comments = comments else { return }
            self.comments = comments
            self.commentsCount = comments.count
        }
    }
    
    func postComment() {
        TimelineService.postComment(timelineId: timeline.id, user: user, text: text) { (comment, error) in
            if let error = error {
                print("DEBUG: Error is \(error.localizedDescription)")
                return
            }
            guard let comment = comment else { return }
            self.comments.insert(comment, at: 0)
            self.commentsCount += 1
        }
    }
    
}
