//
//  ContentView.swift
//  WeatherApp
//
//  Created by Zackary Overend on 27/11/24.
//  991717328

import SwiftUI


struct AdminView: View {
    
    @StateObject var vm = MyViewModel()
     
    var body: some View {
        VStack{
            Text("List of Users")
            
            Button("Get Users"){
                vm.getUsers()
            }
        
            Button("Post Data"){
                var tempFavourites: [String] = []
                
                tempFavourites.append("Toronto")
                
                vm.addUser(userObj: User(id: UUID().uuidString ,name: "Test2", email: "Test@Test1.com", password: "password", favourites: tempFavourites))
            }
        }
        
    }
}

#Preview {
    AdminView()
}
