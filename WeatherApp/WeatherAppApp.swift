//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Zackary Overend on 11/11/24.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct WeatherAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            LoginView(currentUser: User(id: UUID().uuidString, name: "tempName", email: "tempEmail", password: "tempPassword", favourites: []))
//            AdminView()
            //LocationView(favouriteLocation: "Vancouver")
        }
    }
}
