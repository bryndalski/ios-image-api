//
//  ImageViewModel.swift
//  zaliczenie_bryndal
//
//  Created by Jakub Bryn/Users/bryndalski/kodowanie/prywatne/mobile_app/zaliczenie_bryndal/zaliczenie_bryndal/networking/Networking.swiftdal on 17/03/2024.
//

import Foundation


class ImageViewModel: ObservableObject {
    @Published var images: [ImageCardView] = []

    func fetchImages() {
        Task {
            do {
                if let json = try await Networking.Get(url: "http://localhost:3000/api/images/getImages") {
                    // Assuming your JSON response contains an array of images
                    if let imageArray = json["images"] as? [[String: Any]] {
                        let decodedImages = imageArray.compactMap { imageData -> ImageCardView? in
                            if let imageUrl = imageData["imageUrl"] as? String,
                               let imageId = imageData["id"] as? String,
                               let isLoved = imageData["isLoved"] as? Bool,
                               let createdAtString = imageData["createdAt"] as? String,
                               let imageName = imageData["imageName"] as? String,

                               let createdAt = DateFormatter.iso8601Full.date(from: createdAtString) {
                                
                                return ImageCardView(
                                    imageSource: imageUrl,
                                    imageName: imageName,
                                    imageId: imageId,
                                    imageDate: createdAtString,
                                    isLoved: isLoved
                                )
                            }
                            return nil
                        }
                        DispatchQueue.main.async {
                            self.images = decodedImages
                        }
                    }
                }
            } catch {
                print("Error fetching images: \(error)")
            }
        }
    }
}
