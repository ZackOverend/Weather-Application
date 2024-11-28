//
//  LocationView.swift
//  WeatherApp
//
//  Created by Zackary Overend on 2024-11-11.
//  991717328

import SwiftUI



// Code for adjusting background colour dynamically
//https://oguzhanaslann.medium.com/implementing-dynamic-background-color-from-images-in-swift-96e71dd73599

// Code for linear gradient background
//https://www.hackingwithswift.com/quick-start/swiftui/how-to-render-a-gradient

struct LocationView: View {
    @State private var startColour = Color.blue
    @State private var endColour = Color.white

    var body: some View {
        VStack(alignment: .center, spacing: 10.0){
            HStack{
                Text("Toronto")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                Spacer()
                Text("24°C")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
            .padding(.vertical, 30)
            .padding(.horizontal, 30.0)

            VStack(spacing: 10){
                
                
                Text("Placeholder").font(.largeTitle)
                Text("Placeholder").font(.largeTitle)
                Text("Placeholder").font(.largeTitle)
                Text("Placeholder").font(.largeTitle)
                Text("Placeholder").font(.largeTitle)
                Text("Placeholder").font(.largeTitle)
                Text("Placeholder").font(.largeTitle)
                Text("Placeholder").font(.largeTitle)
                Text("Placeholder").font(.largeTitle)
                Text("Placeholder").font(.largeTitle)
                
                Button("Change Background"){
                                            
                    
                }.buttonStyle(.borderedProminent)
                
            }
            .padding(20)
            .frame(width: 350, height: 600, alignment: .topLeading)
            .background(
            Color.black
                .blur(radius: 200)
                .cornerRadius(15)
                .shadow(radius: 10)
            )
            .foregroundStyle(.white)
            
        }
        .padding(10.0)
        .frame(width: 400, height: 750, alignment: .center)
        .background(
            LinearGradient(colors: [startColour, endColour], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .edgesIgnoringSafeArea(.all)
        

    }
}


#Preview {
    LocationView()
}
