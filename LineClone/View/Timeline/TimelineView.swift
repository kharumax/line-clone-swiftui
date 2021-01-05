//
//  TimelineView.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/20.
//

import SwiftUI

struct TimelineView: View {
    
    @ObservedObject var viewModel = TimelineViewModel()
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                VStack {
                    ForEach(viewModel.timelines) { timeline in
                        TimelineCellView(timeline: timeline)
                            .padding(.vertical,8)
                        Divider().border(Color.gray, width: 2)
                    }
                }.padding(.vertical,8)
            }
            HStack {
                Spacer()
                Button(action: { viewModel.isShowPostTimelineView.toggle() }, label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 60,height: 60)
                        .background(Color.white)
                        .foregroundColor(.green)
                        .clipShape(Circle()).padding()
                })
                .sheet(isPresented: $viewModel.isShowPostTimelineView, content: {
                    PostTimelineView(viewModel: viewModel)
                })
            }
        }
    }
}

struct TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView()
    }
}
