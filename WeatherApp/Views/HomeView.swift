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
        
        Text("Location : lat =  \(locationmanager.location.coordinate.latitude)")
        Text("Location : long =  \(locationmanager.location.coordinate.longitude)")
        
       
        
        
    }
    
}


    





#Preview {
    HomeView()
}
