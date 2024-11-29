//
//  ContentView.swift
//  WeatherApp
//
//  Created by Zackary Overend on 27/11/24.
//

import SwiftUI


struct AdminView: View {
    
    @StateObject var vm = MyViewModel()
     
    var body: some View {
        VStack{
            Text("List of Users")
            
            Button("Get Users"){
                vm.getUsers()
            }
        
//            if (vm.userList != []){
//                List {
//                    ForEach(vm.userList ?? [] , id: \.self){ user in
//                        
//                        HStack(spacing:5){
//                            Text("\(user.id)")
//                            Text("Name:  \(user.name)")
//                            Text("Email:  \(user.email)")
//                            Text("Password:  \(user.password)")
//                        }
//                        
//                    }
//                }
//            }
            
            
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
