import Vapor
import Foundation

extension Droplet {
    func setupRoutes() throws {
        get("hello") { req in
            var json = JSON()
            try json.set("hello", "world")
            return json
        }

        get("plaintext") { req in
            return "Hello, world!"
        }

        // response to requests to /info domain
        // with a description of the request
        get("info") { req in
            return req.description
        }

        get("description") { req in return req.description }
        
        try resource("posts", PostController.self)
        let weatherController = WeatherController(self)
        get("weather", handler: weatherController.weather)
//        try resource("weather", WeatherController.self)
        
        setupWeatherRoutes()
    }
    
    private func setupWeatherRoutes() {
//        get("weather") { req in
//            let weatherAPI = WeatherAPIClient(token: "", droplet: self)
//            return try weatherAPI.weather(with: "")
//        }
    }
}
