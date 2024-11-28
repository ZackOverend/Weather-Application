//
//  User.swift
//  WeatherApp
//
//  Created by Frederik Dahl Hansen on 20/11/2024.
//

import Foundation

struct User: Identifiable, Hashable{
    var id = 100
    var name = "Frederik"
    var email = "Frederik@aol.com"
    var password = "password"
    
    init(id: Int = 100, name: String = "Frederik", email: String = "Frederik@aol.com", password: String = "password") {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
    }
    
    func convertToDict( u : User) -> [String : Any]{
        let data : [String : Any] = ["id" :u.id , "name": u.name , "email": u.email, "password": u.password]
        return data
    }
}
