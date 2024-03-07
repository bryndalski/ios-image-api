//
//  LoginButtonView.swift
//  zaliczenie_bryndal
//
//  Created by Jakub Bryndal on 06/03/2024.
//

import SwiftUI

struct LoginButtonView: View {
    let text:String
    
    var body: some View {
        Button(action: {
            print("hhhh")
        }, label: {
            HStack{
                Text(text).fontWeight(Font.Weight.heavy)
                Image(systemName: "arrow.right")
            }.padding(12).frame(minWidth:130)
            
        }).disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            .foregroundColor(.white)
            .background(.yellow)
            .cornerRadius(30)
            .font(.title3).frame(alignment: .bottomLeading)
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

#Preview {
    LoginButtonView(
       text:  "Log in"
    )
}
