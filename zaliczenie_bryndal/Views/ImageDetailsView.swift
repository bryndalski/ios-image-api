//
//  ImageDetailsView.swift
//  zaliczenie_bryndal
//
//  Created by Jakub Bryndal on 18/03/2024.
//

import SwiftUI

struct ImageDetailsView: View {
    let imageName: String
    let imageUrl: String
    
    var body: some View {
        VStack {
            Text("Lovely day :)")
            Text(imageName)
            AsyncImage(url: URL(string: imageUrl)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else if phase.error != nil {
                    // Handle error state
                    Text("Failed to load image")
                } else {
                    // while loading
                    ProgressView()
                }
            }
        
        }
        .navigationTitle(imageName)
    }
}

struct ImageDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDetailsView(imageName: "Sunset", imageUrl: "")
    }
}
