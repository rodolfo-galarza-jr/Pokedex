//
//  APIService.swift
//  Pokedex
//
//  Created by Rodolfo Galarza Jr on 11/24/21.
//

import Foundation

enum NetworkingManager {
    
    enum networkingError: LocalizedError{
        case badURLResponse(url: URL, statusCode: Int)
        case urlResponseFailed(url: URL)
        case jsonDecodingFailed
        case unknown
        
        var errorDescription: String?{
            switch self {
            case .badURLResponse(url: let url, statusCode: let statusCode):
                return "bad response from URL \(url) with status code: \(statusCode)"
            case .urlResponseFailed(url: let url):
                return "response failed from URL: \(url)"
            case .jsonDecodingFailed:
                return "JSON decoding failure"
            case .unknown:
                return "unknown error occurred"
            }
        }
    }
    
    static func fetch<T: Decodable>(type: T.Type, url: String) async throws -> T {
        
        let url = URL(string: url)!
        
        let (data, response) = try await URLSession.shared.data(from: url)
                
        guard let httpResponse = response as? HTTPURLResponse else {
            throw networkingError.urlResponseFailed(url: url)
        }
        
        guard httpResponse.statusCode == 200 else {
            throw networkingError.badURLResponse(url: url, statusCode: httpResponse.statusCode)
        }
    
        do
        {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            print(error)
            throw networkingError.jsonDecodingFailed
        }
    }
    
}
