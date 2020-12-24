//
//  SearchBar.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    var action: () -> Void
    
    var body: some View {
        HStack {
            TextField("Search...",text: $searchText)
                .padding(.vertical,8)
                .padding(.horizontal,24)
                .background(Color(.systemGray5))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Button(action: action) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0,maxWidth: .infinity,alignment: .trailing)
                                .padding()
                                .padding(.horizontal,16)
                        }
                    }
                )
        }
    }
}

//struct SearchBar_Previews: PreviewProvider {
//
//    static var previews: some View {
//        SearchBar(searchText: .constant(""))
//
//    }
//}

