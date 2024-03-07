//
//  LoginButtonView.swift
//  zaliczenie_bryndal
//
//  Created by Jakub Bryndal on 06/03/2024.
//

import SwiftUI

struct LoginButtonView: View {
    let text:String
    let onClick:  ()->Void
    
    var body: some View {
        HStack{
            Button(action:onClick, label: {
                HStack{
                    Text(text).fontWeight(Font.Weight.heavy)
                    Image(systemName: "arrow.right")
                }.padding(12).frame(minWidth:130)
                
            }).foregroundColor(.white)
                .background(.yellow)
                .cornerRadius(30)
                .font(.title3).frame(alignment: .bottomLeading)
               
        } .frame(maxWidth: .infinity, alignment: .trailing)
       
    }
}

#Preview {
    LoginButtonView(
       text:  "Log in",
       onClick: {
           print("Hello world")
       }
    )
}
