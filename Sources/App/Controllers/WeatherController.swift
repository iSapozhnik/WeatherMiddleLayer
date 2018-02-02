//
//  WeatherController.swift
//  Run
//
//  Created by Ivan Sapozhnik on 02.02.18.
//

import Foundation
import Vapor
import HTTP

final class WeatherController {
    let drop: Droplet
    
    init(_ droplet: Droplet) {
        self.drop = droplet
    }

    func weather(_ req: Request) throws -> ResponseRepresentable  {
        let weatherAPI = try WeatherAPIClient(token: appId(), droplet: self.drop)
        let city = req.data["q"]?.string
        let weather = try Weather(json: weatherAPI.weather(with: city ?? "").makeJSON())
        return weather
    }
    
    private func appId() throws -> String {
        let config = try Config()
        return config["app", "weatherAppId"]!.string!
    }
}
