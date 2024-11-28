//
//  LoginView.swift
//  WeatherApp
//
//  Created by Julius Nillo on 2024-11-11.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    
    @StateObject var vm = MyViewModel()
    
    var isFormValid: Bool {
            !email.isEmpty && !password.isEmpty
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                Text("WELCOME").font(.title)
                
                Spacer()
                
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                Spacer()
                
                
                //reference: Styling inspiration and help https://stackoverflow.com/questions/67132408/i-have-trouble-using-cornerradius-and-borders-on-a-textfield-in-swiftui/67132493
                TextField("Please enter username", text: $email)
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
                    Button ("Log In") {
                        
                        //vm.getUsers()
                        
                        
                        print(vm.userList)
                        
                        for user in vm.userList {
                            if (email == user.email && password == user.password){
                                print("----------------------------------")
                                print("success")
                                print("----------------------------------")
                            } else {
                                showAlert = true
                            }
                        }
                        
                    }
                    .disabled(!isFormValid)
                    
                    //https://developer.apple.com/documentation/swiftui/alert
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Incorrect Input"),
                            message: Text("Password inputs must match!")
                        )
                    }
                    .frame(width:100 , height: 55)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(5)
                    .font(.subheadline)
                    .padding(4)
                    
                    NavigationLink("Sign Up", destination: SignUpView())
                        .frame(width:100 , height: 55)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                        .font(.subheadline)
                        .padding(4)
                }
                
            }
            
            
        }
    }
}

#Preview {
    LoginView()
}
