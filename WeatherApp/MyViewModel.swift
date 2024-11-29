//
//  MyViewModel.swift
//  WeatherApp
//
//  Created by Julius Nillo on 2024-11-11.
//


//CODE FROM ASSIGNMENT 3

import Foundation
import FirebaseDatabase


//RESPONSE CONTENT STRUCT
struct ResponseContent : Codable {
    let location : LocationContent
    let current : Current
}

//LOCATION CONTENT STRUCT
struct LocationContent : Codable {
    
    let name : String
    let region : String
    let country : String
    let lat : Double
    let lon : Double
    let tz_id : String
    let localTime_epoch : Int?
    let localTime : String?
    
}

//CURRENT STRUCT
struct Current : Codable {
    
    let temp_c : Double
    let condition : Condition
    let wind_kph : Double
    let wind_dir : String
    let humidity : Int
    let feelslike_c : Double
    let vis_km : Double
    let uv : Double
    
}

//CONDITION STRUCT
struct Condition : Codable {
    let text : String
}


//CREATING THE VIEWMODEL CLASS
class MyViewModel : ObservableObject {
    
//    @Published var userList: [User]?
    @Published var response : ResponseContent?
    @Published var userList: [User]?
    
    var ref : DatabaseReference = Database.database().reference()

    
    var locationManager = LocationManager()

    
    private let api_key = "f0080bbc8b5741a9aff03911240711"
    
    let baseUrl = "https://api.weatherapi.com/v1/forecast.json"
    
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
                
                let items = try JSONDecoder().decode(ResponseContent.self, from: data)
                
                
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
    
    func getLocationByName(locationName: String) {
        
        let location = locationName

        
        let urlStr = "\(baseUrl)?key=\(api_key)&q=\(locationName)"
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
                
                let items = try JSONDecoder().decode(ResponseContent.self, from: data)
                
                
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
