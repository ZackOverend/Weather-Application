//
//  WeatherWidget.swift
//  WeatherWidget
//
//  Created by Frederik Dahl Hansen on 10/12/2024.
//  991695115

import WidgetKit
import SwiftUI


struct Provider: AppIntentTimelineProvider {
    
    
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), city: "Placeholder City", temp_c: 2, condition: "Placeholder Condition", time: "Placeholder Time")
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), city: "Placeholder City", temp_c: 2, condition: "Placeholder Condition", time: "Placeholder Time")
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        
        let vm = WidgetViewModel()
        
        let hour = Calendar.current.component(.hour, from: Date())
        
        let dayHours = 24
        
        
        
        
        
            do{
                try await vm.getObject(city: configuration.favoriteCity)
                
                
                let currentDate = Date()
                
                for hourOffset in hour ..< dayHours {
                    
                    let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
                    let entry = SimpleEntry(date: entryDate, configuration: configuration, city: configuration.favoriteCity, temp_c: Int(vm.object!.forecast.forecastday[0].hour[hourOffset].temp_c), condition: vm.object!.forecast.forecastday[0].hour[hourOffset].condition.text, time:  vm.changeFormat(str: vm.object!.forecast.forecastday[0].hour[hourOffset].time))
                    entries.append(entry)
                }

                
                
            }catch {
                print("error \(error)")
            }
        
        return Timeline(entries: entries, policy: .atEnd)

        
    }

}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let city: String
    let temp_c: Int
    let condition: String
    let time: String
}

struct WeatherWidgetEntryView : View {
    
    
    
    
    
    var entry: Provider.Entry

    var body: some View {
        VStack {
            
            HStack {
                
                Text("Current Forecast Time:")
                Text(entry.time)
                
            }
            
            Spacer()
            
            HStack {
                Text("City:")
                Text(entry.configuration.favoriteCity)
            }
            
            Spacer()
            
            HStack {
                Text("Current Temp: ")
                Text("\(entry.temp_c)°")
            }
            
            Spacer()
            
            HStack {
                Text("Condition: ")
                Text(entry.condition)
            }
        }
    }
}

struct WeatherWidget: Widget {
    let kind: String = "WeatherWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            WeatherWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}
