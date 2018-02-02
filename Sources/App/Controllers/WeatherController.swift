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
    let appId: String
    
    init(_ droplet: Droplet, appId: String) {
        self.drop = droplet
        self.appId = appId
    }

    func weather(_ req: Request) throws -> ResponseRepresentable  {
        let weatherAPI = try WeatherAPIClient(token: appId, droplet: self.drop)
        let city = req.data["q"]?.string
        let weather = try Weather(json: weatherAPI.weather(with: city ?? "").makeJSON())
        return weather
    }
}
