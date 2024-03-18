//
//  ImageViewModel.swift
//  zaliczenie_bryndal
//
//  Created by Jakub Bryn/Users/bryndalski/kodowanie/prywatne/mobile_app/zaliczenie_bryndal/zaliczenie_bryndal/networking/Networking.swiftdal on 17/03/2024.
//

import Foundation


struct ImageData: Identifiable {
    let id: String
    let imageUrl: String
    let imageId: String
    let isLoved: Bool
    let createdAt: String
    let imageName: String
}

class ImageViewModel: ObservableObject {
    @Published var images: [ImageData] = []

    func fetchImages() async {
        do {
            if let json = try await Networking.Get(url: "http://localhost:3000/api/images/getImages") {
                if let imageArray = json["images"] as? [[String: Any]] {
                    print(imageArray)
                    let decodedImages = imageArray.compactMap { imageData -> ImageData? in
                        guard let imageUrlString = imageData["imageUrl"] as? String,
                              let imageId = imageData["id"] as? String,
                              let isLoved = imageData["isLoved"] as? Bool,
                              let createdAtString = imageData["createdAt"] as? String,
                              let id = imageData["id"] as? String,
                              let imageName = imageData["imageName"] as? String
                        else {
                            return nil
                        }
                      
                        return ImageData(
                            id:id,
                            imageUrl: imageUrlString,
                            imageId: imageId,
                            isLoved: isLoved,
                            createdAt: createdAtString,
                            imageName: imageName
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
                print("Empty JSON")
            }
        } catch {
            print("Error fetching images: \(error)")
        }
    }


}
