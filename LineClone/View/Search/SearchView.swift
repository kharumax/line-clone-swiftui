//
//  SearchView.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/20.
//

import SwiftUI

struct SearchView: View {
    
    @State var text: String = ""
    var body: some View {
        ScrollView {
            SearchBar(searchText: $text)
            VStack(alignment: .leading) {
                ForEach(1..<10) { _ in
                    UserCellView()
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
