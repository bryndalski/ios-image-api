//
//  ImageDetails.swift
//  zaliczenie_bryndal
//
//  Created by Jakub Bryndal on 18/03/2024.
//

import SwiftUI

struct ImageDetails: View {
    let imageName: String
    let imageUrl: String
    
    var body: some View {
           VStack {
               // Display image
               AsyncImage(
                   url: URL(string: imageUrl),
                   placeholder: { ProgressView() }
               )
               .scaledToFit()
               .padding()
               
               // Buttons
               HStack {
                   Button("Delete") {
                       // Handle delete action
                   }
                   .foregroundColor(.red)
                   
                   Spacer()
                   
                   Button(action: {
                       // Handle heart button action
                   }) {
                       Image(systemName: "heart")
                   }
                   .foregroundColor(.red)
               }
               .padding()
           }
           .navigationTitle(imageName)
       }
}

#Preview {
    ImageDetails()
}
