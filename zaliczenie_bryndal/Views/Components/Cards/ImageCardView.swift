//
//  ImageCardView.swift
//  zaliczenie_bryndal
//
//  Created by Jakub Bryndal on 07/03/2024.
//

import SwiftUI

struct ImageCardView<Destination: View>: View {
    let imageSource:String
    let imageName: String
    let imageId: String
    let imageDate: String
    let isLoved: Bool
    let destination: Destination

    
    var body: some View {
        NavigationLink(destination: destination) {
            VStack(alignment: .leading,spacing: 16){
                //Card header
                AsyncImage(
                    url:  URL(string:imageSource),
                    content: { image in
                        image.resizable()
                            .frame(width: 350,height: 240)
                            .overlay(
                                alignment: .topLeading
                            ) {
                                HStack {
                                    Spacer()
                                    Image(systemName: isLoved ? "heart.fill" : "heart" ).foregroundColor(.red)
                                }.frame(alignment: .leading).frame(width: 310).padding(20)
                            }
                    },
                    placeholder: {
                        HStack(alignment:.center){
                            ProgressView()
                        }
                    })
                cardText
            }
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
            .shadow(radius: 20)
            
        }
    }
    
    var cardText: some View {
        VStack(alignment: .leading){
            Text(imageName).font(.headline)
            HStack{
                Image(systemName: "calendar")
                Text(imageDate)
            }.padding(.bottom,15).foregroundColor(.gray)
        }.frame(width: 340, alignment: .topLeading).padding(.leading,10)
    }
}
