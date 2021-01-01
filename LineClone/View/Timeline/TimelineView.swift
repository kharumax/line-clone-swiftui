//
//  TimelineView.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/20.
//

import SwiftUI

struct TimelineView: View {
    
    @State var isShowPostTimelineView = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                VStack {
                    ForEach(0..<10) { _ in
                        TimelineCellView().padding(.vertical,8)
                        Divider().border(Color.gray, width: 2)
                    }
                }.padding(.vertical,8)
            }
            Button(action: { self.isShowPostTimelineView.toggle() }, label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 60,height: 60)
                    .background(Color.white)
                    .foregroundColor(.green)
                    .clipShape(Circle()).padding()
            })
            .sheet(isPresented: $isShowPostTimelineView, content: {
                PostTimelineView(isShowPostTimelineView: $isShowPostTimelineView)
            })
        }
    }
}

struct TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView()
    }
}
