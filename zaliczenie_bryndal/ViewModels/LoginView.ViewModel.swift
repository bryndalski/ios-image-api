//
//  LoginView.ViewModel.swift
//  zaliczenie_bryndal
//
//  Created by Jakub Bryndal on 06/03/2024.
//

import Foundation
import Amplify

class LoginViewModel:ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var invlalidCredentials = false
    
    func signIn() async-> Bool {
        do {
            print(email,password)
            let signInResult = try await Amplify.Auth.signIn(
                username: email,
                password: password
                )
            if signInResult.isSignedIn {
               return true
            } else{
                return false
            }
        } catch let error as AuthError {
            print("Sign in failed \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
        return false
    }
}
