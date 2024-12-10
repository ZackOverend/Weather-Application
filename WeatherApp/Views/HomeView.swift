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
    
    @State var currentLocationName : String = ""
    
    let currentUser: User
    
    var body: some View {
        
        
        //DISPLAYS THE CURRENT LOCATION
        
        NavigationStack{
            
            
            Text("Home Page").font(.largeTitle).bold()
            
            //FOR TESTING PURPOSES
            //            Text("Location : lat =  \(locationmanager.location.coordinate.latitude)")
            //            Text("Location : long =  \(locationmanager.location.coordinate.longitude)")
            
            Text("👤 Current user: \(currentUser.name)")
            Text("Weather in Current Location:").bold()
            
            
            
//            VStack {
//                
//                ForEach(currentUser.favourites, id: \.self) {
//                    
//                    favourite in
//                    
//                    NavigationLink(destination: LocationView(favouriteLocation: favourite)) {
//                        
//                        HomeCardView(locationName: favourite, currentUser: currentUser)
//                        
//                            
//                        
//                    }.tint(.black)
//                    
//                    
//
//                    
//                }
//            }
            
            VStack {
                
                NavigationLink(destination: LocationView(favouriteLocation: currentUser.favourites[0])) {
                    
                    HomeCardView(locationName: currentUser.favourites[0], currentUser: currentUser)
                }.tint(.black)
                
                Text("\(currentLocationName)")
                
            }.onAppear() {
                
//                Task {
//                    do {
//                        
//                        try await vm.getLocationByCords()
//                        
//                        currentLocationName = vm.response?.location.name ?? ""
//                        
//                        
//                        
//                    } catch {
//                        print("")
//                    }
//                }
            }
                
            
        
            
//                HomeCardView(locationName: currentUser.favourites[0], currentUser: currentUser)
              
            
            
            if(currentUser.favourites.count > 1)
            {
                Text("Weather in Other Locations").bold()
                
                // current problem: toronto is displaying in other locations
                
                
                // DISPLAYING WEATHER IN OTHER LOCATIONS
//                VStack {
//                    
//                   // HomeCardView(locationName: "Placeholder", currentUser: currentUser)
//                    
//                }
                
                // first location (weather in current location, in favourite list)
                //
                
                ForEach(currentUser.favourites, id: \.self) {
                    
                    favourite in
                    
                    // Makes sure we don't display the first element of favourites list again
                    if(favourite != currentUser.favourites[0]){
                        HomeCardView(locationName: favourite, currentUser: currentUser)
                        
                    }
                    
                }

                
                
                
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
            
            Text("🌍 Location: \(locationName)").font(.headline)
            
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
