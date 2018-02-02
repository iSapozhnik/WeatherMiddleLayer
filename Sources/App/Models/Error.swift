//
//  Error.swift
//  App
//
//  Created by Ivan Sapozhnik on 02.02.18.
//

import Foundation

final class Error {
    var description: String
    
    struct Keys {
        static let description = "description"
    }
    
    init(description: String) {
        self.description = description
    }
}

extension Error: JSONConvertible {
    convenience init(json: JSON) throws {
        self.init(
            description: try json.get(Error.Keys.description)
        )
    }
    
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set(Error.Keys.description, description)
        return json
    }
}
