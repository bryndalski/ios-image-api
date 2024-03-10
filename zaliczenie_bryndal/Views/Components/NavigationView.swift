//
//  NavigationView.swift
//  zaliczenie_bryndal
//
//  Created by Jakub Bryndal on 09/03/2024.
//

import SwiftUI

struct NavigationView: View {
    @ObservedObject var loginManager : MainViewModel
    
    var body: some View {
        TabView {
            LovedImagesView()
                .tabItem {
                    Label("Loved",
                          systemImage: "heart")
                }
            
           HomeView()
                .tabItem {
                    Label("Home",
                          systemImage: "photo.fill")
                }
            
            ProfileView(loginManager: loginManager)
                .tabItem {
                    Label("Profile",
                          systemImage: "person")
                }
        }
    }
}

//#Preview {
//    NavigationView()
//}
