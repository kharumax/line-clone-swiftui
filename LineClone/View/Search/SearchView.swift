//
//  SearchView.swift
//  LineClone
//
//  Created by 久保田陽人 on 2020/12/20.
//

import SwiftUI

struct SearchView: View {
    
    @State var searchText = ""
    @ObservedObject var viewModel = SearchViewModel()
    
    func searchUsers() {
        viewModel.searchUsers(searchText: searchText)
    }
    
    var body: some View {
        ScrollView {
            HStack {
                SearchBar(searchText: $searchText, action: searchUsers)
            }.padding(.horizontal,8)
            VStack(alignment: .leading) {
                ForEach(viewModel.users) { user in
                    UserCellView(user: user)
                }
            }
        }
    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
