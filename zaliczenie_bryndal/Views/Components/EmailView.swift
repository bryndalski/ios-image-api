//
//  EmailView.swift
//  zaliczenie_bryndal
//
//  Created by Jakub Bryndal on 06/03/2024.
//

import SwiftUI

struct EmailView: View {
    
    @Binding var email: String // Accept a binding for the password text

    var body: some View {
        HStack{
            Image(systemName: "envelope").foregroundColor(.gray)
            TextField("Email",text:$email).autocapitalization(.none)
        }    }
}

#Preview {
    EmailView(
        email: .constant("")
    )
}
