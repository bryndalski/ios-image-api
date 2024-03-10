//
//  LoginView.swift
//  zaliczenie_bryndal
//
//  Created by Jakub Bryndal on 06/03/2024.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var loginManager : MainViewModel
    @StateObject var loginViewModel =  LoginViewModel()
    @Environment(\.verticalSizeClass) var sizeClass

    let textFieldSWithSubtitle = TextWithSubtitle(title: "Login", subtitle: "Please login to view your images")

    
    
    var body: some View {
        
        VStack(alignment: .center){
            if UIDevice.current.orientation.isPortrait {
                // Handle portrait orientation
                textFieldSWithSubtitle.frame(width: UIScreen.main.bounds.width - 50).padding(.top,250)
            } else {
                // Handle landscape orientation
                textFieldSWithSubtitle.frame(alignment: .leadingLastTextBaseline).padding(.top,30)
            }
            
            VStack{
                Form{

                    EmailView(email: $loginViewModel.email)
                    PasswordView(password: $loginViewModel.password)
                        .disableAutocorrection(true)
                }.frame(maxWidth: 450)
                .scrollContentBackground(.hidden)
                .background(Color(UIColor.systemBackground))
                .persistentSystemOverlays(.hidden)
                .scrollDisabled(true)
                
                LoginButtonView(
                text: "log in",
                onClick: {
                    Task {
                        if await loginViewModel.signIn() {
                            loginManager.setSignedIn()
                        }
                    }
                }
                ).offset(x:-10) .alert("Invalid credentials", isPresented: $loginViewModel.invlalidCredentials) {
                    Button("OK", role: .cancel) { }
                }
                
                
            }.frame(
                maxWidth: 450,
                maxHeight:200
            )
            
            
            Button(action: {
                Alert(title: Text("Button not implemented"))
            }, label: {

                Text("Forgot password ?").fontWeight(.regular)                .foregroundColor(.blue).padding(.top,20)
            })
            
            Spacer()
 
            if UIDevice.current.orientation.isPortrait {
                Image(uiImage: UIImage(named: "LoginWave")!.resize(Int(UIScreen.main.bounds.width), Int(UIScreen.main.bounds.width))).frame(
                                maxHeight: 50
                        )
            }
        }.ignoresSafeArea(.all).frame(maxWidth: 400)
            
            .overlay(
                Image(uiImage: UIImage(named: "LoginBlob")!.resize(90,60)).position(
                    x:0,y:90
                ).zIndex(3).frame(maxHeight: 50)
            )

          
        
            
    }
}
