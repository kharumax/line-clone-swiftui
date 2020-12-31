//
//  TimelineView.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/20.
//

import SwiftUI

struct TimelineView: View {
    var body: some View {
        VStack {
            HStack {
                Image("ironman")
                    .resizable()
                    .frame(width: 50,height: 50)
                    .cornerRadius(25)
                Text("ironman").font(.system(size: 24,weight: .semibold))
                Spacer()
            }
            Image("ironman")
                .resizable()
                .scaledToFill()
                .frame(height: 400)
            HStack {
                Text("I am ironman ... ")
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding()
            }
            HStack {
                
            }
        }
    }
}

struct TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView()
    }
}
