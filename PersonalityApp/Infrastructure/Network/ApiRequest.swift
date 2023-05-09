//
//  ApiRequest.swift
//  PersonalityApp
//
//  Created by Mehmed Tukulic on 9. 5. 2023..
//

import Foundation

struct APIRequest {
    let url: String
    let headers: JSON
    let parameters: JSON?
    let method: HTTPMethod

    init(url: String,
         headers: JSON = [:],
         parameters: JSON? = nil,
         method: HTTPMethod = .GET) {
        self.url = url
        self.headers = headers
        self.parameters = parameters
        self.method = method
    }
}

public typealias JSON = [String: Any]

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}
