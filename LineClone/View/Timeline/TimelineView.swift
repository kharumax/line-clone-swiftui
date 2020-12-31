//
//  TimelineView.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/20.
//

import SwiftUI

struct TimelineView: View {
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<10) { _ in
                    TimeLineCellView().padding(.vertical,8)
                    Divider().border(Color.gray, width: 2)
                }
            }.padding(.vertical,8)
        }
    }
}

struct TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView()
    }
}
