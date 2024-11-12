//
//  MyLocationManager.swift
//  WeatherApp
//
//  Created by Julius Nillo on 2024-11-11.
//

//CODE FROMA ASSIGNMENT 3

import Foundation
import MapKit
import CoreLocation

class LocationManager : NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let manager = CLLocationManager()
    
    @Published var location : CLLocation = CLLocation()
    
    override init() {
        super.init()
        
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        guard let location = locations.last else {
            print("error")
            return
        }

        self.location = location
        print(location)
        
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
                case .authorizedAlways, .authorizedWhenInUse :
                   print("authorize")
            
            manager.startUpdatingLocation()
                   break

               case .notDetermined:
                   manager.requestWhenInUseAuthorization()

               case .restricted:
                   print("restricted")

               default:
                   print("default")
            
            
        }
    }
    
}
