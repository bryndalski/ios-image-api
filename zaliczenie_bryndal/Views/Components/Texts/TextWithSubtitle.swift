//
//  TextWithSubtitle.swift
//  zaliczenie_bryndal
//
//  Created by Jakub Bryndal on 06/03/2024.
//

import SwiftUI

struct TextWithSubtitle: View {
    let title:String
    let subtitle:String
    
    
    var body: some View {
        VStack(alignment: .listRowSeparatorLeading) {
            Text(title).font(.largeTitle)
            Text(subtitle).font(.headline)
        }.frame(
            alignment:.topLeading
        ).frame(width: .infinity)
    }
}

#Preview {
    TextWithSubtitle(
        title: "Welcome to ImageApp", subtitle:"Please log in"
    )
}
