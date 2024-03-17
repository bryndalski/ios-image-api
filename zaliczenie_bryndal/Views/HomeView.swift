//
//  HomeView.swift
//  zaliczenie_bryndal
//
//  Created by Jakub Bryndal on 09/03/2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject var imageViewModel = ImageViewModel()
    @State private var isLoading = false

    var body: some View {
        VStack {
            if isLoading {
                ProgressView()
            } else if !imageViewModel.images.isEmpty {
                ScrollView {
                    LazyVStack {
                        ForEach(imageViewModel.images, id: \.imageId) { imageCardView in
                            imageCardView
                                .padding()
                        }
                    }
                }
            } else {
                Text("No images")
                    .font(.title)
                    .foregroundColor(.gray)
            }
        }
        .onAppear {
            Task {
                isLoading = true
                await imageViewModel.fetchImages()
                isLoading = false
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
