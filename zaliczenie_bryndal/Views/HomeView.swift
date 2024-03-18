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
    @State private var isRefreshing = false

    var body: some View {
        NavigationStack {
            VStack {
                if isLoading {
                    ProgressView()
                } else if !imageViewModel.images.isEmpty {
                    ScrollView {
                        LazyVStack {
                            ForEach(imageViewModel.images, id: \.imageId) { imageData in
                                ImageCardView(
                                    imageSource: imageData.imageUrl, imageName: imageData.imageName, imageId: imageData.imageId, imageDate: imageData.imageName, isLoved:imageData.isLoved,
                                    
                                    destination: ImageDetailsView(
                                        imageName: imageData.imageName, imageUrl: imageData.imageUrl
                                    )
                                )
                                .padding()
                            }
                        }
                    }
                    .refreshable {
                        await refreshImages()
                    }
                    .overlay(refreshControl)
                } else {
                    Text("No images")
                        .font(.title)
                        .foregroundColor(.gray)
                }
            }
            .onAppear {
                isLoading = true
                Task {
                    await imageViewModel.fetchImages()
                    isLoading = false
                }
            }
        }
    }

    private func refreshImages() async {
        isRefreshing = true
        await imageViewModel.fetchImages()
        isRefreshing = false
    }

    private var refreshControl: some View {
        GeometryReader { geometry in
            if geometry.frame(in: .global).minY < -50 && !isRefreshing {
                ProgressView()
                    .offset(y: geometry.frame(in: .global).minY + 40)
                    .padding(.bottom, -40)
            }
        }
        .frame(height: 0)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
