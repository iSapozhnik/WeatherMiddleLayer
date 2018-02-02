//
//  WeatherAPIClient.swift
//  App
//
//  Created by Ivan Sapozhnik on 02.02.18.
//

import Foundation
import Vapor
import HTTP

extension Status {
    var isSuccessfulRequest: Bool {
        return self.statusCode >= 200 && self.statusCode < 300
    }
}

final class WeatherAPIClient {
    let token: String
    let droplet: Droplet
    
    struct Config {
        static let baseURL = "http://api.openweathermap.org/data/2.5/weather?"
    }
    
    init(token: String, droplet: Droplet) {
        self.token = token
        self.droplet = droplet
    }
    
    func perform(_ request: Request) throws -> JSON {
        let response = try self.droplet.client.respond(to: request)
        if response.status.isSuccessfulRequest {
            if let json = response.json {
                return json
            }
        }

        if let bytes = response.body.bytes {
            let json = try JSON(bytes: bytes)
            return json
        } else {
            return try Error(description: "Something went wrong!").makeJSON()
        }
    }
    
    func weather(with city: String) throws -> JSON {
        let uri = "http://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&appid=\(self.token)"
        let request = Request(method: .get, uri: uri)
        let json = try self.perform(request)
        return json
    }
}
