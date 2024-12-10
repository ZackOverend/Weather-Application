//
//  LocationView.swift
//  WeatherApp
//
//  Created by Zackary Overend on 2024-11-11.
//  991717328

import SwiftUI
import GoogleGenerativeAI


// Code for adjusting background colour dynamically
//https://oguzhanaslann.medium.com/implementing-dynamic-background-color-from-images-in-swift-96e71dd73599

// Code for linear gradient background
//https://www.hackingwithswift.com/quick-start/swiftui/how-to-render-a-gradient

// https://stackoverflow.com/questions/57727107/how-to-get-the-iphones-screen-width-in-swiftui
// Allows card to dynamically adjust based on width of phone
let screenWidth = UIScreen.main.bounds.width

struct LocationView: View {
    @State private var startColour = Color.blue
    @State private var endColour = Color.white
    @State private var foregroundColour = Color.white
    
    @State private var isLoaded = false
    
    // TODO: Have favouriteLocation be retrieved from HomeView()
    var favouriteLocation: String
    
    @StateObject private var vm = MyViewModel()

    var body: some View {
        if (isLoaded){
            VStack{
                let responseData: Object? = vm.response
                                
                VStack(alignment: .center, spacing: 10.0){
                    // Top weather data outside of card
                    TitleWeatherData(response: responseData, favouriteLocation: favouriteLocation, foregroundColour: foregroundColour)
                    
                    // Card
                    VStack{
                        CardTopData(response: responseData)
                        
                        CardDetailData(response: responseData)
                        
                        CardAiGendescription(location: favouriteLocation)
                        Spacer()

                        CardHorizontalScroll(intervalHours: vm.intervalHours)
                    }
                    .padding(20)
                    .frame(width: screenWidth * 0.85, height: 600, alignment: .topLeading)
                    .foregroundStyle(foregroundColour)
                    .background(
                        Color.black
                            .blur(radius: 200)
                            .cornerRadius(15)
                            .shadow(radius: 10)
                        )
                    
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

struct TitleWeatherData: View {
    let response: Object?
    let favouriteLocation: String
    var foregroundColour = Color.white
    var body: some View {
        
        let country = response?.location.country ?? ""
        let region = response?.location.region ?? ""
        let currentWeatherIcon = response?.current.condition.icon ?? ""
        
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
    }
}

struct CardTopData: View {
    let response: Object?

    var body: some View {
        let temp_c = response?.current.temp_c ?? 0
        let feelslike_c = response?.current.feelslike_c ?? 0
        VStack{
            Text("\(String(format: "%.1f", temp_c))°C").font(.title)
            Text("Feels like ") + Text("\(String(format: "%.1f", feelslike_c))°C").font(.subheadline).bold()
        }

    }
}

struct CardDetailData: View {
    let response: Object?
    
    var body: some View {
        let wind_kph = response?.current.wind_kph ?? 0
        let wind_dir = response?.current.wind_dir ?? ""
        let humidity = response?.current.humidity ?? 0
        let uv = response?.current.uv ?? 0
        let vis_km = response?.current.vis_km ?? 0
        
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
    }
}

struct CardHorizontalScroll: View {
    var intervalHours: [Hour]

    var body: some View {
        ScrollView(.horizontal){
            HStack(spacing: 7) {
                ForEach(intervalHours, id: \.time) { hour in
                    // Card Background
                    VStack {
                        // Content
                        VStack{
                            // String formatting reference
                            //https://stackoverflow.com/questions/32967445/how-to-check-what-a-string-starts-with-prefix-or-ends-with-suffix-in-swift
                            Text("\(hour.time)")
                                .font(.title3)
                            AsyncImage(url: URL(string: "https:\(hour.condition.icon)"))
                                .frame(width: 64, height:64)
                            Spacer()

                            Text("\(String(format: "%.1f", hour.temp_c))°C")
                                .font(.title2)
                        }
                    }
                    .frame(width: 82, height: 150)
                    .background(Color.white.opacity(0.2))
                    .shadow(radius: 5)
                    .foregroundStyle(.white)
                    .cornerRadius(5)
                    .padding(.bottom, 15)
                }
            }
        }
    }
}

struct CardAiGendescription: View {
    let location: String
    
    struct MyKey {
        static let API_KEY = "AIzaSyB79dWDOjQr3KMTz2F2yFmsh6Y5v79KJu8"
        static let textRequest = "Create a description with exactly 20-30 words (try to not use the word 'vibrant' so much) and be sure to include the name of the location (but not the region or country and use ',' instead of ':') for:"
    }
    
    @State var response = "Loading Location Description..."

    
    var body: some View {
        
        VStack{

            Text(response)
                .multilineTextAlignment(.center)
                .padding(10)
            
                
        }
        .frame(width: screenWidth * 0.75, height: 150, alignment: .center)
        .background(
            Color.white
            .blur(radius: 200)
            .cornerRadius(15)
            .shadow(radius: 10)
            .opacity(20)
        )
        .onAppear(){
            Task{
                do{
                    let model = GenerativeModel(name: "gemini-1.5-flash" , apiKey: MyKey.API_KEY)
                    let output  = try await model.generateContent("\(MyKey.textRequest)\(location)")
                    
                    guard let text = output.text else {
                        
                        print("error ")
                        return
                    }
                    
                    DispatchQueue.main.async {
                    
                        self.response = text
                    }
                    
                  }catch{
                    
                    print("error \(error)")
                }
                
            }
        }
        
    }
    
}
    
    




#Preview {
    LocationView(favouriteLocation: "Banff")
}
