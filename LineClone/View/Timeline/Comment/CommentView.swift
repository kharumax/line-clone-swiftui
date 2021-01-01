//
//  CommentView.swift
//  LineClone
//
//  Created by 久保田陽人 on 2021/01/01.
//

import SwiftUI

struct CommentView: View {
    
    @State var text = ""
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    ForEach(0..<10) { _ in
                        CommentCellView()
                        Divider().border(Color.black, width: 2)
                    }
                }
            }
            Divider().border(Color.black, width: 3)
            HStack {
                TextField("Comment here ..",text: $text).font(.system(size: 20,weight: .semibold)).padding(.bottom,4)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.leading,8)
                    Button(action: {}, label: {
                        Text("送信").foregroundColor(.white).font(.system(size: 20,weight: .semibold))
                            .padding(.horizontal).padding(.vertical,4)
                    }).background(Color.green).cornerRadius(15)
                    .padding(.trailing,16).frame(alignment: .trailing)
                
            }.frame(maxWidth: .infinity)
        }.padding(.top)
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView()
    }
}
