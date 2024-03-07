//
//  LoginView.swift
//  zaliczenie_bryndal
//
//  Created by Jakub Bryndal on 06/03/2024.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var loginViewModel =  LoginViewModel()
    
    var body: some View {
        

        
      
        
        
        VStack(alignment: .center){
            TextWithSubtitle(title: "Login", subtitle: "Please login to view your images").frame(width: UIScreen.main.bounds.width-50,alignment: .leadingLastTextBaseline).padding(.top,200)
            
            
                Form{
                    //Fields
                    EmailView(email: $loginViewModel.email)
                    PasswordView(password: $loginViewModel.password)
                        .disableAutocorrection(true)

                    
                    LoginButtonView(
                    text: "log in"
                    ).padding(.top,20).contentMargins(0).offset(x:12)
                    
                }.scrollContentBackground(.hidden)
                .background(Color(UIColor.systemBackground))
                .persistentSystemOverlays(.hidden)
            
            
            
            Button(action: {
                print("hhhh")
            }, label: {

                Text("Forgot password ?").fontWeight(.regular)                .foregroundColor(.blue)
            }).frame(maxWidth: .infinity, alignment: .center)
            
            Spacer()
            
            Image(uiImage: UIImage(named: "LoginWave")!.resize(Int(UIScreen.main.bounds.width), Int(UIScreen.main.bounds.width)))
        }.ignoresSafeArea(.all).overlay(
            Image(uiImage: UIImage(named: "LoginBlob")!.resize(90,60)).position(
                x:150,y:50
            ).zIndex(3)
    
        )

            
    }
}

#Preview {
    LoginView()
}
