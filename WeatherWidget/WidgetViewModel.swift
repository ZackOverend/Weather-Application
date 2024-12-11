//  Created by Frederik Dahl Hansen on 10/12/2024.
//  991695115

import Foundation



struct Object: Codable {
    let location: CityLocation
    let forecast: Forecast
}

struct CityLocation: Codable {
    let name: String
    let country: String
}

struct Forecast: Codable {
    
    let forecastday: [ForecastDay]
    
}

struct ForecastDay: Codable {
    
    let hour: [Hour]
    
}

struct Hour: Codable {
    
    let time: String
    let temp_c: Double
    let condition: HourCondition
    
    
}

struct HourCondition: Codable {
    
    let text: String
    let icon: String
    
}



class WidgetViewModel: ObservableObject {
    
    
    let baseUrl1 = "https://api.weatherapi.com/v1/forecast.json?key=17c558fe59df44ac81f190537240911&q="
    let baseUrl2 = "&days=1&aqi=no&alerts=no"
    
    @Published var object: Object?
    
    //based on example from class
    func getObject(city: String) async throws {
        
        
        
        
        let urlStr = baseUrl1+"\(city)"+baseUrl2
        
        let url = URL(string: urlStr)!
        
        let (data, _) =  try await URLSession.shared.data(for: URLRequest(url:url))
        
        let result = try JSONDecoder().decode(Object.self, from: data)
        
        DispatchQueue.main.async {
            self.object = result
        }
        
        print(result)
        
        
    }
    
    //reference for implementation: https://stackoverflow.com/questions/61546387/how-to-get-only-time-from-date-in-swift
    func changeFormat(str:String) -> String {
        let dateFormatter = DateFormatter()

        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let date = dateFormatter.date(from: str)!

        dateFormatter.dateFormat = "HH:mm"
        let string = dateFormatter.string(from: date)
        return string
    }
    
    
    
    
    //reference for the string format https://www.kodeco.com/books/swift-cookbook/v1.0/chapters/6-use-string-formatting-in-swift
    func formatter(val: Double) -> String {
        
        let number = val
        let formattedNumber = String(format: "%.0f", number)
        
        return formattedNumber
        
    }
    
    
}
