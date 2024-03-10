//
//  PasswordView.swift
//  zaliczenie_bryndal
//
//  Created by Jakub Bryndal on 06/03/2024.
//

import SwiftUI

struct PasswordView: View {
    @State private var isPasswordShown = false
    @Binding var password: String // Accept a binding for the password text

    var body: some View {
        HStack {
            Image(systemName: "key").foregroundColor(.gray).frame(
                width: 22
            )

            if isPasswordShown {
                TextField("Password", text: $password).autocapitalization(.none)
            } else {
                SecureField("Password", text: $password).autocapitalization(.none)
            }

            Button(action: {
                isPasswordShown.toggle()
            }, label: {
                Image(systemName: isPasswordShown ? "eye.slash.fill" : "eye.fill").foregroundColor(.gray)
            })
        }
    }
}

struct PasswordView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordView(password: .constant("")) // Example usage
    }
}
