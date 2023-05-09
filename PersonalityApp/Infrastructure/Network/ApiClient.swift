//
//  ApiClient.swift
//  PersonalityApp
//
//  Created by Mehmed Tukulic on 9. 5. 2023..
//

import Foundation

protocol APIProtocol {
    func makeRequest<R:Decodable>(_ session: URLSession, _ request: APIRequest) async throws -> R
}

class APIClient: APIProtocol {
    func makeRequest<R>(_ session: URLSession = .shared, _ request: APIRequest) async throws -> R where R : Decodable {
        guard let url = URL(string: request.url) else { throw NetworkingError.invalidUrl }
        var urlRequest = URLRequest(url: url)

        if let parameters = request.parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw NetworkingError.failedToEncode(error: error)
            }
        } else {
            urlRequest.httpBody = nil
        }

        urlRequest.httpMethod = request.method.rawValue

        let (data, response) = try await session.data(for: urlRequest)

        guard let response = response as? HTTPURLResponse,
              (200...300) ~= response.statusCode else {
          let statusCode = (response as! HTTPURLResponse).statusCode
          throw NetworkingError.invalidStatusCode(statusCode: statusCode)
        }

        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(R.self, from: data)

            return result
        } catch {
            throw NetworkingError.failedToDecode(error: error)
        }
    }
}

enum NetworkingError: LocalizedError {
    case invalidUrl
    case custom(error: Error)
    case invalidStatusCode(statusCode: Int)
    case failedToEncode(error: Error)
    case failedToDecode(error: Error)
}
