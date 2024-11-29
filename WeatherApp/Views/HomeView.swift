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
            
            Text("Home Page").font(.largeTitle)
            
            //FOR TESTING PURPOSES
//            Text("Location : lat =  \(locationmanager.location.coordinate.latitude)")
//            Text("Location : long =  \(locationmanager.location.coordinate.longitude)")
            
            
            Text("Weather in Current Location")
            
            if (vm.response?.location) != nil {
                
                VStack {
                    Text("\(currentUser.name)")
//                    HomeCardView(locationName: vm.response?.location.country ?? "", temperature: vm.response?.current.temp_c ??  0.0)
                
                    
                }
            } else {
                Text("Fetching location needed...")
            }
            
            
            Text("Weather in Other Locations")
            
            // DISPLAYING WEATHER IN OTHER LOCATIONS
            VStack {
                
            }
            
            Spacer()
            
            
            Spacer()
            
            
//            Button("Refresh") {
//                vm.getLocation()
//            }
            
        }.onAppear() {
            Task{
                vm.getLocationByCords()
            }
        }
    }
    
}

//testing purposes
struct HomeCardView: View {
    
    var locationName : String
    var temperature : Double
    var currentUser: User
    
    var body: some View {
        
            
        VStack {
            
            Text("🌍 \(locationName)")
            
            Text("🌡️ \(temperature, specifier: "%.1f")")
            
            Text("Time: Placeholder")
            
            
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
