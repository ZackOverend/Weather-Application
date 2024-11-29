//
//  FavouriteView.swift
//  WeatherApp
//
//  Created by Julius Nillo on 2024-11-29.
//

import SwiftUI

struct FavouriteView: View {
    var body: some View {
        Text("Favourites ❤️").font(.largeTitle)
        
        ScrollView(.vertical) {
            
            
            
            //card vstack
            VStack {
                
                CardView(
                    
                )
                
                CardView(
                    
                )
                
            }
                        
        }
        .padding()
    }
}

struct CardView: View {
    
    
    var body: some View {
            
        VStack {
            
            Text("Placeholder")
            
            Text("100°C")
            
            
        }
        .padding(20)
        .frame(width: 350, height: 100, alignment: .topLeading)
        .background(.yellow)
        .clipShape(RoundedRectangle(cornerRadius: 25))
               
        
    }
}


#Preview {
    FavouriteView()
}
