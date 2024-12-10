//
//  FavouritesView.swift
//  WeatherApp
//
//  Created by Zackary Overend on 10/12/24.
//

import SwiftUI

struct FavouritesView: View {
    
    @EnvironmentObject var vm: MyViewModel
    
    @State var locationName = ""
    @State var updatedFavourites: [String] = []

    
    let currentUserId: String
    
    var body: some View {
        let currentUser = vm.getUserById(id: currentUserId)
        
        VStack{
            List{
                ForEach(currentUser.favourites, id: \.self){favourite in
                    Text("\(favourite)")
                }.onDelete(perform: { indexSet in
                    removeFavourite(at: indexSet, currentUser: currentUser)
                })
            }
            
            Spacer()
            
            VStack{
                TextField(text: $locationName, label: {
                    Text("Enter Location Name")
                })
                
                Button("Add to Favourites"){
                    
                    updatedFavourites = []
                    
                    
                    // Populate new favourits list
                    for favourite in currentUser.favourites{
                        updatedFavourites.append(favourite)
                    }
                    
                    
                    updatedFavourites.append(locationName)
                    
                    
                    // Create updateUser that will be pushed to database with new favourites list
                    let updatedUser = User(id: currentUser.id, name: currentUser.name, email: currentUser.email, password: currentUser.password, favourites: updatedFavourites)
                    
                    vm.removeUser(userObj: currentUser)
                    vm.addUser(userObj: updatedUser)
                    
                    vm.getUsers()
                }
            }
            
        }
    }
    
    func removeFavourite(at offsets: IndexSet, currentUser: User){
        
        updatedFavourites = []
        for favourite in currentUser.favourites{
            updatedFavourites.append(favourite)
        }
        
        updatedFavourites.remove(atOffsets: offsets)
        let updatedUser = User(id: currentUser.id, name: currentUser.name, email: currentUser.email, password: currentUser.password, favourites: updatedFavourites)
        
        
        // Remove then add the userobject to the database
        vm.removeUser(userObj: currentUser)
        vm.addUser(userObj: updatedUser)
        // Update user list
        vm.getUsers()

    }
}
//
//#Preview {
//    FavouritesView(user: User(id: "101", favourites: ["Test"]))
//}
