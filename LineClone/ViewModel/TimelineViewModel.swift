//
//  TimelineViewModel.swift
//  LineClone
//
//  Created by 久保田陽人 on 2021/01/01.
//

import SwiftUI

class TimelineViewModel: ObservableObject {
    
    @Published var timelines = [Timeline]()
    @Published var caption = ""
    @Published var selectedImage: UIImage?
    @Published var isShowPostTimelineView = false
    var isPostValid: Bool {
        return (!caption.isEmpty && selectedImage != nil)
    }
    
    init() {
        fetchTimelines()
    }
    
    func fetchTimelines() {
        TimelineService.fetchTimelines { (timelines, error) in
            if let error = error {
                print("DEBUG: Error is \(error.localizedDescription)")
                return
            }
            guard let timelines = timelines else { return }
            self.timelines = timelines
        }
    }
    
    func postTimeline(user: User) {
        guard let selectedImage = selectedImage else { return }
        TimelineService.postTimeline(user: user, caption: caption, image: selectedImage) { (timeline, error) in
            if let error = error {
                print("DEBUG: Error is \(error.localizedDescription)")
                return
            }
            guard let timeline = timeline else { return }
            self.timelines.append(timeline)
            self.isShowPostTimelineView.toggle()
        }
    }
    
}
