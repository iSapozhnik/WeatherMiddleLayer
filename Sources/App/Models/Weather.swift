//
//  Weather.swift
//  Run
//
//  Created by Ivan Sapozhnik on 02.02.18.
//

import Vapor
import FluentProvider
import HTTP

final class Weather {
    let storage = Storage()
    
    var id: Int
    var temperature: String
    var city: String
    
    struct RequestKeys {
        static let id = "id"
        static let temperature = "main.temp"
        static let city = "name"
    }
    
    struct ResponseKeys {
        static let id = "id"
        static let temperature = "temp"
        static let city = "city"
    }
    
    init(id: Int, temperature: String, city: String) {
        self.id = id
        self.temperature = temperature
        self.city = city
    }
}

extension Weather: JSONConvertible {
    convenience init(json: JSON) throws {
        self.init(
            id: try json.get(Weather.RequestKeys.id),
            temperature: try json.get(Weather.RequestKeys.temperature),
            city: try json.get(Weather.RequestKeys.city)
        )
    }
    
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set(Weather.ResponseKeys.id, id)
        try json.set(Weather.ResponseKeys.temperature, temperature)
        try json.set(Weather.ResponseKeys.city, city)
        return json
    }
}

extension Weather: ResponseRepresentable { }
