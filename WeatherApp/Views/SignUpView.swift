//
//  SignUpView.swift
//  WeatherApp
//
//  Created by Julius Nillo on 2024-11-11.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var userName = ""
    @State private var password = ""
    @State private var retypePassword = ""
    
    
    var body: some View {
        NavigationView {
            VStack {
                Text("SIGN UP").font(.title)
                
                Spacer()
                
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                
                Spacer()
                
                //reference: Styling inspiration and help https://stackoverflow.com/questions/67132408/i-have-trouble-using-cornerradius-and-borders-on-a-textfield-in-swiftui/67132493
                TextField("Please enter username", text: $userName)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0)))
                    .padding()
                
                //hide input reference: https://developer.apple.com/documentation/swiftui/securefield
                TextField("Please enter password", text: $password)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0)))
                    .padding()
                
                TextField("Please re-enter password", text: $retypePassword)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0)))
                    .padding()
                
                Spacer()
                
                
                //Placeholder
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

#Preview {
    SignUpView()
}
