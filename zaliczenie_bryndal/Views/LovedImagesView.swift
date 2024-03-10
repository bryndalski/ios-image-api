//
//  LovedImagesView.swift
//  zaliczenie_bryndal
//
//  Created by Jakub Bryndal on 09/03/2024.
//

import SwiftUI

struct LovedImagesView: View {
    var body: some View {
        ScrollView{
            ImageCardView(
                imageSource: "https://picsum.photos/id/12/600",
                imageName: "Beautiful Sunset",
                imageId: "12345",
                imageDate: "March 7, 2024",
                isLoved: true
            )
            ImageCardView(
                imageSource: "https://picsum.photos/id/12/600",
                imageName: "Beautiful Sunset",
                imageId: "12345",
                imageDate: "March 7, 2024",
                isLoved: true
            )
            ImageCardView(
                imageSource: "https://picsum.photos/id/12/600",
                imageName: "Beautiful Sunset",
                imageId: "12345",
                imageDate: "March 7, 2024",
                isLoved: true
            )
        }
       
    }
}

#Preview {
    LovedImagesView()
}
