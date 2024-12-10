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
    
    
    //@State var currentLocationName : String = ""
    
    var currentUser: User
    
    var body: some View {
        
        
        //DISPLAYS THE CURRENT LOCATION
        
        var currentLocationName : String = vm.response?.location.name ?? ""
        
        NavigationStack{
            
            
            Text("Home Page").font(.largeTitle).bold()
            
            //FOR TESTING PURPOSES
            //            Text("Location : lat =  \(locationmanager.location.coordinate.latitude)")
            //            Text("Location : long =  \(locationmanager.location.coordinate.longitude)")
            
            Text("👤 Current user: \(currentUser.name)")
            Text("Weather in Current Location:").bold()
            
            
            VStack {
                
                NavigationLink(destination: LocationView(favouriteLocation: currentLocationName)) {
                    
                    HomeCardView(locationName: currentLocationName, currentUser: currentUser)
                }.tint(.black)
                
                
            }.onAppear() {
                
                Task {
                    do {
                        
                        vm.getLocationByCords()
                        
                        
                    } catch {
                        print("")
                    }
                }
            }
                
            
//          HomeCardView(locationName: currentUser.favourites[0], currentUser: currentUser)
              
            
            
            if(currentUser.favourites.count > 1)
            {
                Text("Weather in Other Locations").bold()
                
                ForEach(currentUser.favourites, id: \.self) {
                    
                    favourite in
                    
                    // Makes sure we don't display the first element of favourites list again
                    if(favourite != currentUser.favourites[0]){
                        
                        
                        NavigationLink(destination: LocationView(favouriteLocation: favourite)) {
                            
                            HomeCardView(locationName: favourite, currentUser: currentUser)
                            
                        }.tint(.black)
                  
                        
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
