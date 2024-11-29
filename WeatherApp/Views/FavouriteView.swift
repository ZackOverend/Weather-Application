//
//  FavouriteView.swift
//  WeatherApp
//
//  Created by Julius Nillo on 2024-11-29.
//

import SwiftUI

struct FavouriteView: View {
    var body: some View {
        ScrollView(.vertical) {
            
            Text("Favourites ❤️").font(.largeTitle)
            
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
            
            
        }
        .frame(width: 250, height: 400)
        .background(.yellow)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        //.blur(radius: 200)
    }
}


#Preview {
    FavouriteView()
}
