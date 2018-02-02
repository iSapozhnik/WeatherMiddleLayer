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
        setupWeatherRoutes()
    }
    
    private func setupWeatherRoutes() {
        guard let appId = self.config["app", "weatherAppId"]?.string else {
            self.console.error("Missing app id!")
            self.console.warning("Add one in Config/secrets/app.json")
            
            fatalError()
        }
        
        let weatherController = WeatherController(self, appId: appId)
        get("weather", handler: weatherController.weather)
    }
}
