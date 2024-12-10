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
    let tz_id: String
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
    var time: String
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
    
    @Published var response : Object?
    @Published var userList: [User]?
    @Published var intervalHours: [Hour] = []
    
    @Published var currentHour: Int = 0
    @Published var locationHour: Int = 0
//    @Published var intervalHours: [Hour] = []

    
    var ref : DatabaseReference = Database.database().reference()

    
    var locationManager = LocationManager()

    
    private let api_key = "7c86052efa3246ba93a33436241111"
    let baseUrl = "https://api.weatherapi.com/v1/forecast.json"
    let numberOfDays = 2
    
    func getLocationByCords(){
        
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
                    self.calculateInterval()
                    self.locationHour = self.getLocationHour()
                    self.currentHour = self.getCurrentHour()
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
                let f = obj["favourites"]
                
                //print("-------------")
                //print("id = \(id)")
                //print("name = \(n)")
                //print("email = \(e)")
                //print("password = \(p)")
                let user = User(id: id as! String, name: n as! String, email: e as! String, password: p as! String, favourites: f as! [String])
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
    
    // Helper function for calculateInterval
    func getLocationHour() -> Int{
        let responseLocalTime = response?.location.localtime ?? ""

        let dateFormatter = DateFormatter()
        
        // dateFormatter.date information from here
        //https://www.swiftyplace.com/blog/swift-date-formatting-10-steps-guide
        let date = dateFormatter.date(from: responseLocalTime)
        let responseTimeZone = TimeZone(identifier: response?.location.tz_id ?? "America/New_York")
        
        // Calendar information from here
        //https://developer.apple.com/documentation/foundation/calendar/component
        var calendar = Calendar.current
        calendar.timeZone = responseTimeZone!
        
        // The integer representation of the current hour
        // Defaults to local device hour we can't find the timezone
        return Int(calendar.component(.hour, from: date ?? Date()))
    }
    
    // Helper function for calculateInterval
    func getCurrentHour() -> Int{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        
        return Int(dateFormatter.string(from: Date())) ?? 0
    }
    
    // Calculates the 24 hour time interval relative to the provided by the viewmodel
    func calculateInterval(){
        intervalHours = []
        // Gets an integer representation of the current time hour in the viewmodels location
        let locationHour: Int = getLocationHour()
        
        // Gets an integer representation of the current time hour in the devices location
        let currentHour: Int = getCurrentHour()
        
        // Retrieves the combined 48 hours of the day today and tomorrow
        let forecast48Hours: [Hour] = (response?.forecast.forecastday[0].hour ?? []) + (response?.forecast.forecastday[1].hour ?? [])
        
        for i in 1...24 {
            // Since we want the 24 hour interval to display the next forecasted 24 hours, add i
            var iterationHour: Hour = forecast48Hours[locationHour+i]

            // Take the current hour of the users timezone, adds the iteration then
            // takes the remainder, since we can't have it display the hour as "30:00" for example instead we want "6:00"
            let relativeTime: String = "\((currentHour + i) % 24)"
            
            // offset the current hours time to that of the correct timezone
            iterationHour.time = "\(relativeTime):00"
            
            // Append to published variable
            intervalHours.append(iterationHour)
        }

        
    }
}
