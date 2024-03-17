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
            
           HomeView()
                .tabItem {
                    Label("Home",
                          systemImage: "photo.fill")
                }
            
            
           BrowserImages()
                .tabItem {
                    Label("add new",
                          systemImage: "photo.badge.plus.fill")
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
