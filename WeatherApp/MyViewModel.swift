//
//  MyViewModel.swift
//  WeatherApp
//
//  Created by Julius Nillo on 2024-11-11.
//


//CODE FROM ASSIGNMENT 4 with slight edits

import Foundation
import FirebaseDatabase


struct Object: Codable{
    let location: Location
    let current: Current
    let forecast: Forecast
}

// Nested in Weather
struct Location: Codable {
    let name: String
    let region: String
    let country: String
    let localtime: String
}

// Nested in Weather
struct Current: Codable{
    let condition: Condition
    
    let temp_c: Double
    let feelslike_c: Double
    let wind_kph: Double
    let wind_dir: String
    let uv: Double
    let humidity: Double
    let vis_km: Double
    
}

// Nested in Weather
struct Forecast: Codable{
    let forecastday: [ForecastDay]
    struct ForecastDay: Codable{
        let hour: [Hour]
    }
    
}

// Nested in Weather -> Current | Nested in Weather -> Forecast
struct Condition: Codable{
    let text: String
    let icon: String
}

// Nested in Weather -> Forecast -> ForecastDay
struct Hour: Codable{
    let time: String
    let temp_c: Double
    let feelslike_c: Double
    let wind_kph: Double
    let wind_dir: String
    let uv: Double
    let humidity: Double
    let vis_km: Double
    
    let condition: Condition
}



//CREATING THE VIEWMODEL CLASS
class MyViewModel : ObservableObject {
    
//    @Published var userList: [User]?
    @Published var response : Object?
    @Published var userList: [User]?
    
    var ref : DatabaseReference = Database.database().reference()

    
    var locationManager = LocationManager()

    
    private let api_key = "7c86052efa3246ba93a33436241111"
    let baseUrl = "https://api.weatherapi.com/v1/forecast.json"
    let numberOfDays = 2
    
    func getLocation() {
        
        let lat = locationManager.location.coordinate.latitude
        let long = locationManager.location.coordinate.longitude
                
        
        let urlStr = "\(baseUrl)?key=\(api_key)&q=\(lat),\(long)"
        print(urlStr)
        print("lat: \(locationManager.location.coordinate.latitude) long: \(locationManager.location.coordinate.longitude)")
        
        // using the API
        let url = URL(string: urlStr)
        
        let task = URLSession.shared.dataTask(with: url!) {
            
            data, response, error in
            
            guard error == nil else {
                
                print("error \(error)")
                return
                
            }
            
            guard let data = data else {
                
                print("error data not found")
                return
                
            }
            
            do {
                
                let items = try JSONDecoder().decode(Object.self, from: data)
                
                
                DispatchQueue.main.async {
                    self.response = items
                    
                }
                
                print(items)
                
            }catch {
                
                print("error \(error)")
            }
            
            
        }
        
        task.resume()
        
    }
    
    func getLocationByName(locationName: String) async throws{
        
        let location = locationName

        let urlStr = baseUrl + "?key=\(api_key)" + "&q=\(location)" + "&days=\(numberOfDays)"
        print(urlStr)
        
        // using the API
        let url = URL(string: urlStr)
        
        let task = URLSession.shared.dataTask(with: url!) {

            data, response, error in
            
            guard error == nil else {
                
                print("error \(error)")
                return
                
            }
            
            guard let data = data else {
                
                print("error data not found")
                return
                
            }
            
            do {
                
                let items = try JSONDecoder().decode(Object.self, from: data)
                
                
                DispatchQueue.main.async {
                    self.response = items
                    
                }
                
                print(items)
                
            }catch {
                
                print("error \(error)")
            }
            
            
        }
        
        task.resume()
        
    }
    
    func getUsers(){

        self.ref.child("userList").observe(DataEventType.value, with: { (snapshot) in
            var tempList: [User] = []

            
            let postDict = snapshot.value as? [AnyObject] ?? []
            
            for data in snapshot.value as! [ String : Any] {
                let obj : [String : Any] = data.value as! [String : Any]
                let id = obj["id"]!
                let n = obj["name"]!
                let e = obj["email"]!
                let p = obj["password"]!
                
                //print("-------------")
                //print("id = \(id)")
                //print("name = \(n)")
                //print("email = \(e)")
                //print("password = \(p)")
                let user = User(id: id as! String, name: n as! String, email: e as! String, password: p as! String)
                tempList.append(user)
                
            }
            DispatchQueue.main.async {
                self.userList = tempList
            }
        })
       
    }
    
    // TODO: Create a post when user signs up. Check to make sure the email doesn't already exist in database!
    func addUser(userObj: User) {
            
        
        self.ref.child("userList")
            .child("\(userObj.id)").setValue(userObj.convertToDict(u: userObj)) {
                error ,_  in print("done")
            }
        }
}
