//
//  LazyView.swift
//  LineClone
//
//  Created by 久保田陽人 on 2021/01/07.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping() -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
}


