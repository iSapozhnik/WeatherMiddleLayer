import App

/// We have isolated all of our App's logic into
/// the App module because it makes our app
/// more testable.
///
/// In general, the executable portion of our App
/// shouldn't include much more code than is presented
/// here.
///
/// We simply initialize our Droplet, optionally
/// passing in values if necessary
/// Then, we pass it to our App's setup function
/// this should setup all the routes and special
/// features of our app
///
/// .run() runs the Droplet's commands, 
/// if no command is given, it will default to "serve"

enum Error: Swift.Error {
    /// Missing appId key in Config/secrets/app.json.
    case missingAppId
}

let config = try Config()
try config.setup()

let drop = try Droplet(config)

guard let appId = drop.config["app", "weatherAppId"]?.string else {
    drop.console.error("Missing app id!")
    drop.console.warning("Add one in Config/secrets/app.json")
    
    /// Throw missing secret key error.
    throw Error.missingAppId
}

try drop.setup()

try drop.run()
