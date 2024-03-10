//
//  MainViewModel.swift
//  zaliczenie_bryndal
//
//  Created by Jakub Bryndal on 09/03/2024.
//

import Foundation
import Amplify
import AWSCognitoAuthPlugin

class MainViewModel: ObservableObject{
    
    
    @Published var isLoggedIn: Bool = false
    @Published var isLoading: Bool = true
    @Published var familyName: String = ""
    @Published var givenName: String = ""
    @Published var email: String = ""

   

    
    init() {
        Task(priority: .medium){
            await configureAmplify()
        }
    }
    // Initializes Amplify
    final func configureAmplify() async {
        await MainActor.run{
            isLoading = true
        }
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.configure()
            print("Amplify configured with auth plugin")
            print("Amplify initialized")
            await getUser()
            
        } catch {
            print("Failed to initialize Amplify with \(error)")
        }
        
        await MainActor.run{
            isLoading = false

        }
    }
    
    func getUser() async {
       do {
           let session = try await Amplify.Auth.fetchAuthSession()
           let user = try await Amplify.Auth.fetchUserAttributes()

           user.forEach { AuthUserAttribute in
               switch AuthUserAttribute.key {
                   case .familyName:
                       familyName = AuthUserAttribute.value as String
                   case .givenName:
                       givenName = AuthUserAttribute.value as String
                   case .email:
                       email = AuthUserAttribute.value as String
                   default:
                       break
               }
           }

           await MainActor.run{
               isLoggedIn = session.isSignedIn
           }
       } catch {
           print("Failed to fetch user data")
           await MainActor.run{
               isLoggedIn = false
           }
       }
   }
    
    func setSignedOut() {
        isLoading = false
        isLoggedIn = false
    }
    
    
    func setSignedIn(){
        isLoading = false
        isLoggedIn = true
    }
       
}
