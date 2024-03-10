//
//  ProfileView.swift
//  zaliczenie_bryndal
//
//  Created by Jakub Bryndal on 09/03/2024.
//

import SwiftUI
import Amplify

struct ProfileView: View {
    @ObservedObject var loginManager : MainViewModel
    @State var isDarkModeEnabled: Bool = true
    @State var downloadViaWifiEnabled: Bool = false
    
    var body: some View {
            Form {
                Group {
                    HStack{
                        Spacer()
                        VStack {
                            Text(loginManager.familyName + " " + loginManager.givenName)
                                .font(.title)
                            Text(loginManager.email)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        Spacer()
                    }
                }
                
                
                Section(header: Text("PREFRENCES"), content: {
                    HStack{
                        Image(systemName: "heart")
                        Text("Language")
                    }
                    HStack{
                        Image(systemName: $isDarkModeEnabled.wrappedValue ? "moon.stars" : "sun.max")
                        Toggle(isOn: $isDarkModeEnabled) {
                            Text("Dark Mode")
                        }
                    }
                    
                })
                
                Spacer()
                
                Button(action: {
                    Task {
                       await Amplify.Auth.signOut()
                       await MainActor.run {
                           loginManager.setSignedOut()
                        }
                    }
                }) {
                    Text("Log Out")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(20)
                        .padding(.horizontal)
                }
            }
    }
}
