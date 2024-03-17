//
//  BrowserInagesViewModel.swift
//  zaliczenie_bryndal
//
//  Created by Jakub Bryndal on 17/03/2024.
//

import SwiftUI

class BrowserInagesViewModel: ObservableObject {
    func sendImageToAPI(_ image: UIImage) async {
        // Convert UIImage to  
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("Failed to convert image to data.")
            return
        }
        
        // URL of your API endpoint
        let apiUrl = "http://localhost:3000/api/images/add"
        
        // Call the Post method with the API URL and image data
        await Networking.PostImage(url: apiUrl, imageData: imageData)
    }
}

