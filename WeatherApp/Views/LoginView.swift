//
//  LoginView.swift
//  WeatherApp
//
//  Created by Julius Nillo & Frederik on 2024-11-11.
//  991721936

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var userFound = false
    
    @State var currentUser: User
    
    @StateObject var vm = MyViewModel()
    
    
    var isFormFilled: Bool {
            !email.isEmpty && !password.isEmpty
    }
    
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Spacer()
                
                Text("WELCOME").font(.title)
                    .foregroundStyle(Color.white)
                
                Spacer()
                
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                Spacer()
                
                
                //reference: Styling inspiration and help https://stackoverflow.com/questions/67132408/i-have-trouble-using-cornerradius-and-borders-on-a-textfield-in-swiftui/67132493
                TextField("Please enter email", text: $email)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0)))
                    .padding()
                
                //hide input reference: https://developer.apple.com/documentation/swiftui/securefield
                SecureField("Please enter password", text: $password)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0)))
                    .padding()
                
                Spacer()
                
                HStack {
                    Button("Log in"){
                        // must redirect to HomeView() only if the email and password is valid
                        // If the fields are empty, the navigationLink should be unclickable
                        
                        for user in vm.userList ?? []{
                            if (user.email == email && user.password == password){
                                showAlert = false
                                userFound = true
                                currentUser = user
                                break
                            }
                            else{
                                userFound = false
                                showAlert = true
                            }
                        }
                    }
                    .disabled(!isFormFilled)
                    //https://developer.apple.com/documentation/swiftui/alert
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Incorrect Input"),
                            message: Text("Please enter valid email and password")
                        )
                    }
                    .frame(width:100 , height: 55)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(5)
                    .font(.subheadline)
                    .padding(4)
                    /*Xcode notified that the NavigationLink method was deprecated using isActive. Instead we must take this approach.
                    https://developer.apple.com/documentation/swiftui/view/navigationdestination(for:destination:)
                     */
                    .navigationDestination(isPresented: $userFound){
                        HomeView(currentUser: currentUser, currentUserId: currentUser.id).environmentObject(vm)
                    }
   
                    NavigationLink("Sign Up", destination: SignUpView().environmentObject(vm))
                        .frame(width:100 , height: 55)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                        .font(.subheadline)
                        .padding(4)
                }
                
                
                
            }
            .background(
                LinearGradient(colors: [Color.blue, Color.white], startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            
            
        }.onAppear(){
            
                vm.getUsers()
                vm.getLocationByCords()
            
        }
    }
    
}

#Preview {
    LoginView(currentUser: User(id: UUID().uuidString, name: "tempName", email: "tempEmail", password: "tempPassword", favourites: []))
}
