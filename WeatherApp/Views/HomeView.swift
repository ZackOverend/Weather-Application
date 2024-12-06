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
    
    let currentUser: User
    
    var body: some View {
        
        //DISPLAYS THE CURRENT LOCATION
        
        NavigationStack{
            
            Text("Home Page").font(.largeTitle).bold()
            
            //FOR TESTING PURPOSES
            //            Text("Location : lat =  \(locationmanager.location.coordinate.latitude)")
            //            Text("Location : long =  \(locationmanager.location.coordinate.longitude)")
            
            Text("👤 Current user: \(currentUser.name)")
            
            
            
            VStack {
                
                ForEach(currentUser.favourites, id: \.self) {
                    
                    favourite in
                    
                    NavigationLink(destination: LocationView(favouriteLocation: favourite)) {
                        
                        HomeCardView(locationName: favourite, currentUser: currentUser)
                        
                            
                        
                    }.tint(.black)
                    
                    
                    
                    
                }
            }
        
            
//                HomeCardView(locationName: currentUser.favourites[0], currentUser: currentUser)
              
            
            
            
            Text("Weather in Other Locations").bold()
            
            // DISPLAYING WEATHER IN OTHER LOCATIONS
            VStack {
                
                HomeCardView(locationName: "Placeholder", currentUser: currentUser)
                
            }
            
            Spacer()
            
            
            Spacer()
            
            
//            Button("Refresh") {
//                vm.getLocation()
//            }
            
        }
    }
    
}

//testing purposes
struct HomeCardView: View {
    
    var locationName : String
    //var temperature : Double
    var currentUser: User
    
    var body: some View {
        
            
        VStack {
            
            Text("🌍 Weather in Current Location: \(locationName)").font(.headline)
            
            //Text("🌡️ \(temperature, specifier: "%.1f")")
            
            
            
        }
        
        .padding(20)
        .frame(width: 350, height: 100, alignment: .topLeading)
        .background(
            Color.blue
                .blur(radius: 100)
                .shadow(radius: 5)
            )
        .clipShape(RoundedRectangle(cornerRadius: 25))
        
               
        
    }
    
}


    





#Preview {
    HomeView(currentUser: User(id: UUID().uuidString, name: "tempName", email: "tempEmail", password: "tempPassword", favourites: []))
}
