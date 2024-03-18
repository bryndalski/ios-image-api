//
//  ImageViewModel.swift
//  zaliczenie_bryndal
//
//  Created by Jakub Bryn/Users/bryndalski/kodowanie/prywatne/mobile_app/zaliczenie_bryndal/zaliczenie_bryndal/networking/Networking.swiftdal on 17/03/2024.
//

import Foundation


class ImageViewModel: ObservableObject {
    @Published var images: [ImageCardView] = []

    func fetchImages() async {
        do {
            if let json = try await Networking.Get(url: "http://localhost:3000/api/images/getImages") {
                if let imageArray = json["images"] as? [[String: Any]] {
                    print(imageArray)
                    let decodedImages = imageArray.compactMap { imageData -> ImageCardView? in
                        guard let imageUrlString = imageData["imageUrl"] as? String,
                              let imageId = imageData["id"] as? String,
                              let isLoved = imageData["isLoved"] as? Bool,
                              let createdAtString = imageData["createdAt"] as? String,
                              let imageName = imageData["imageName"] as? String
                        else {
                            print("BUUU")
                            return nil
                        }
                      
                        return ImageCardView(
                            imageSource: imageData["imageUrl"],
                            imageName: imageName,
                            imageId: imageId,
                            imageDate: createdAtString,
                            isLoved: isLoved
                        )
                    }
                    DispatchQueue.main.async {
                        print(decodedImages)
                        self.images = decodedImages
                    }
                } else {
                    print("Images key not found in JSON response.")
                }
            } else {
                print("Empty JSON response.")
            }
        } catch {
            print("Error fetching images: \(error)")
        }
    }


}
