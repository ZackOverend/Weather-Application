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
            
            List {
                ForEach(vm.userList , id: \.self){ user in
                    
                    HStack(spacing:5){
                        
                        Text("Id : \(user.id)")
                        Text("Name:  \(user.name)")
                        Text("Email:  \(user.email)")
                        Text("Password:  \(user.password)")
                    }
                    
                }
            }
            
            Button("Post Data"){
                vm.addUser(userObj: User(id: 102, name: "Test1", email: "Test@Test1.com", password: "password"))
            }
        }
        
    }
}

#Preview {
    AdminView()
}
