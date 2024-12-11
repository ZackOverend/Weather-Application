//
//  HomeView.swift
//  WeatherApp
//
//  Created by Julius Nillo on 2024-11-11.
//  991721936

// reference:
// https://www.youtube.com/watch?v=BpJqsjzG-bs


import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var vm: MyViewModel
    @StateObject var locationmanager = LocationManager()
    
    
    //@State var currentLocationName : String = ""
    
    @State var currentUser: User
    @State var currentUserId: String
    
    var body: some View {
        
        
        //DISPLAYS THE CURRENT LOCATION
        
        let currentLocationName : String = vm.response?.location.name ?? ""
        
        NavigationStack{
            
            
            Text("Home Page").font(.largeTitle).bold()
            
            //FOR TESTING PURPOSES
            //            Text("Location : lat =  \(locationmanager.location.coordinate.latitude)")
            //            Text("Location : long =  \(locationmanager.location.coordinate.longitude)")
            
            Text("👤 Current user: \(currentUser.name)")
            Text("Current Location:").bold()
            
            
            VStack {
                
                NavigationLink(destination: LocationView(favouriteLocation: currentLocationName)) {
                    
                    HomeCardView(locationName: vm.response?.location.name ?? "Oakville", currentUser: currentUser)
                }.tint(.black)
                
                
            }.onAppear() {
                
                vm.getUsers()
                vm.getLocationByCords()
            }
                
//                for user in vm.userList!{
//                    if(user.id == currentUserId)
//                    {
//                        currentUser = user
//                        break
//                    }
//                        
//                }
//            }
                
            
//          HomeCardView(locationName: currentUser.favourites[0], currentUser: currentUser)
              
            
            
            
            if(currentUser.favourites.count > 0)
            {
                Text("Favourites List").bold()
                ScrollView{
                    ForEach(vm.getUserById(id: currentUserId).favourites, id: \.self) {
                        
                        favourite in
                        
                        // Makes sure we don't display the first element of favourites list again
                            
                        NavigationLink(destination: LocationView( favouriteLocation: favourite)) {
                            
                            HomeCardView(locationName: favourite, currentUser: currentUser)
                            
                        }.tint(.black)
                        
                            
                        
                        
                    }

                }
            }
            
            Spacer()
            
            
            HStack {
                
                NavigationLink(destination:
                                FavouritesView(currentUserId: currentUserId).environmentObject(vm)){
                    Text("Edit Locations")
                }
                                .frame(width:130 , height: 55)
                                .background(.blue)
                                .foregroundColor(.white)
                                .cornerRadius(5)
                                .font(.subheadline)
                                .padding(4)
                
                Button("Refresh Current Location") {
                    vm.getLocationByCords()
                }
                .frame(width:130 , height: 55)
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(5)
                .font(.subheadline)
                .padding(4)
            }
            
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
    HomeView(currentUser: User(id: UUID().uuidString, name: "tempName", email: "tempEmail", password: "tempPassword", favourites: []), currentUserId: "")
}
