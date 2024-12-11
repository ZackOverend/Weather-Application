//
//  AppIntent.swift
//  WeatherWidget
//
//  Created by Frederik Dahl Hansen on 10/12/2024.
//  991695115

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource { "Configuration" }
    static var description: IntentDescription { "This is an example widget." }

    // An example configurable parameter.
    @Parameter(title: "Enter City", default: "Oakville")
    var favoriteCity: String
}
