//
//  WeatherRoutes.swift
//  App
//
//  Created by Ivan Sapozhnik on 02.02.18.
//

import Vapor

class WeatherRoutes {
    class func setupRoutes(appId: String, droplet: Droplet) {
        let weatherController = WeatherController(droplet, appId: appId)
        droplet.get("weather", handler: weatherController.weather)
    }
}
