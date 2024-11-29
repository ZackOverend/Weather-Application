//
//  HomeView.swift
//  WeatherApp
//
//  Created by Julius Nillo on 2024-11-11.
//

// reference:
// https://www.youtube.com/watch?v=BpJqsjzG-bs


import SwiftUI

struct HomeView: View {
    
    @StateObject var vm = MyViewModel()
    @StateObject var locationmanager = LocationManager()
    
    var body: some View {
        
        //DISPLAYS THE CURRENT LOCATION
        
        Text("Home").font(.largeTitle)
        
        //FOR TESTING PURPOSES
        Text("Location : lat =  \(locationmanager.location.coordinate.latitude)")
        Text("Location : long =  \(locationmanager.location.coordinate.longitude)")
        
        
        VStack {
            HomeCardView()
        }
        
        Spacer()
        
        Spacer()
        
    }
    
}

//testing purposes
struct HomeCardView: View {
    
    
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
    HomeView()
}
