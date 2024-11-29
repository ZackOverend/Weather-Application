//
//  LocationView.swift
//  WeatherApp
//
//  Created by Zackary Overend on 2024-11-11.
//  991717328

import SwiftUI

// Code for adjusting background colour dynamically
//https://oguzhanaslann.medium.com/implementing-dynamic-background-color-from-images-in-swift-96e71dd73599

// Code for linear gradient background
//https://www.hackingwithswift.com/quick-start/swiftui/how-to-render-a-gradient

struct LocationView: View {
    @State private var startColour = Color.blue
    @State private var endColour = Color.white
    @State private var foregroundColour = Color.white
    
    @State private var isLoaded = false
    
    // TODO: Have favouriteLocation be retrieved from FavouriteView()
    var favouriteLocation: String
    
    @StateObject private var vm = MyViewModel()
    

    var body: some View {
        if (isLoaded){
            VStack{
                let country = vm.response?.location.country ?? ""
                let region = vm.response?.location.region ?? ""

                
                let currentWeatherIcon = vm.response?.current.condition.icon ?? ""
                let temp_c = vm.response?.current.temp_c ?? 0
                let feelslike_c = vm.response?.current.feelslike_c ?? 0
                let wind_kph = vm.response?.current.wind_kph ?? 0
                let wind_dir = vm.response?.current.wind_dir ?? ""
                let humidity = vm.response?.current.humidity ?? 0
                let uv = vm.response?.current.uv ?? 0
                let vis_km = vm.response?.current.vis_km ?? 0
                
                VStack(alignment: .center, spacing: 10.0){
                    // Top weather data outside of card
                    HStack{
                        VStack(alignment: .leading){
                            Text("\(favouriteLocation)").font(.title)
                            
                            // I noticed some locations don't have a region, so this accounts for that
                            if !region.isEmpty{
                                Text("\(region), \(country)").font(.title3)
                            }else{
                                Text("\(country)").font(.title3)
                            }
                            
                        }
                        Spacer()
                        AsyncImage(url: URL(string: "https:\(currentWeatherIcon)"))
                            .frame(width:64, height:64)
                    }
                    .foregroundStyle(foregroundColour)
                    .padding(.vertical, 30)
                    .padding(.horizontal, 30.0)

                    // Details
                    VStack{
                        VStack{
                            Text("\(String(format: "%.1f", temp_c))°C").font(.title)
                            Text("Feels like ") + Text("\(String(format: "%.1f", feelslike_c))°C").font(.subheadline).bold()
                        }// Top Current Info VStack
                        
                                            
                        VStack{
                            HStack{
                                Text("Wind Speed:")
                                Spacer()
                                Text("\(String(format: "%.1f", wind_kph))kph").bold()
                            }
                            HStack{
                                Text("Wind Direction:")
                                Spacer()
                                Text("\(wind_dir)").bold()
                            }
                            HStack{
                                Text("Humidity:")
                                Spacer()
                                Text("\(String(format: "%.1f", humidity))").bold()
                            }
                            HStack{
                                Text("UV Index:")
                                Spacer()
                                Text("\(String(format: "%.1f",uv))").bold()
                            }
                            
                            HStack{
                                Text("Visibility")
                                Spacer()
                                Text("\(String(format: "%.1f",vis_km))km").bold()
                            }
                        }// Details Card VStack
                        .padding(20)
                        
                        Spacer()
                        
                        ScrollView(.horizontal){
                            HStack(spacing: 7) {
                            }
                        }// Horizontal Scroll
                    }
                    .padding(20)
                    .frame(width: 350, height: 600, alignment: .topLeading)
                    .background(
                        Color.black
                            .blur(radius: 200)
                            .cornerRadius(15)
                            .shadow(radius: 10)
                        )
                    .foregroundStyle(foregroundColour)
                    
                }
                .padding(10.0)
                .frame(width: 400, height: 750, alignment: .center)
                
                
            }
            //https://www.hackingwithswift.com/quick-start/swiftui/how-to-place-content-outside-the-safe-area
            .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
            .background(
                LinearGradient(colors: [startColour, endColour], startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .ignoresSafeArea()
        }
        else{
            VStack{
                Text("Loading Weather Data...").font(.title)
            }.onAppear(){
                Task{
                    do{
                        try await vm.getLocationByName(locationName: "\(favouriteLocation)")
                        isLoaded = true
                    }
                    catch{
                        print("ERROR, could not retrieve data")
                    }
                }
                
            }
        }
    } // View Body
}


#Preview {
    LocationView(favouriteLocation: "Toronto")
}
