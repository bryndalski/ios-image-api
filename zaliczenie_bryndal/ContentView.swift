//
//  ContentView.swift
//  zaliczenie_bryndal
//
//  Created by Jakub Bryndal on 06/03/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var cognitoModel =  MainViewModel()

    
    
    var body: some View {
            VStack {
                if cognitoModel.isLoading{
                    ProgressView()
                }else {
                    if cognitoModel.isLoggedIn {
                        NavigationView(loginManager:cognitoModel)
                    } else {
                        LoginView(loginManager: cognitoModel)
                    }
                }
            }
        }
}

#Preview {
    ContentView()
}
