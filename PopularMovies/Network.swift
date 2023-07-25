//
//  Network.swift
//  PopularMovies
//
//  Created by Luis Lasierra on 25/7/23.
//

import SwiftUI

public enum NetworkError:Error {
    case general(Error)
    case status(Int)
    case json(Error)
    case dataNotValid
    case noHTTP
    case unknown
    case badFilename
    
    public var description:String {
        switch self {
        case .general(let error):
            return "General error \(error.localizedDescription)"
        case .status(let int):
            return "Status error: \(int)"
        case .json(let error):
            return "JSON error: \(error)"
        case .dataNotValid:
            return "Not valid data"
        case .noHTTP:
            return "No HTTP connection"
        case .unknown:
            return "Unknown error"
        case .badFilename:
            return "Bad filename or directory!"
        }
    }
}

public final class Network {
    public static let shared = Network()
    
    public func getJSON<JSON:Codable>(request:URLRequest, type:JSON.Type, decoder:JSONDecoder = JSONDecoder()) async throws -> JSON {
        let (data, response) = try await URLSession.shared.dataRequest(for: request)
        guard let response = response as? HTTPURLResponse else { throw NetworkError.noHTTP }
        if response.statusCode == 200 {
            do {
                return try decoder.decode(JSON.self, from: data)
            } catch {
                throw NetworkError.json(error)
            }
        } else {
            throw NetworkError.status(response.statusCode)
        }
    }
    
    public func post(request:URLRequest, statusOK:Int = 200) async throws {
        let (_, response) = try await URLSession.shared.dataRequest(for: request)
        guard let response = response as? HTTPURLResponse else { throw NetworkError.noHTTP }
        if response.statusCode != statusOK {
            throw NetworkError.status(response.statusCode)
        }
    }
    
    #if os(iOS)
    public func getImage(url:URL) async throws -> UIImage {
        let (data, response) = try await URLSession.shared.dataRequest(from: url)
        guard let response = response as? HTTPURLResponse else { throw NetworkError.noHTTP }
        if response.statusCode == 200 {
            if let image = UIImage(data: data) {
                return image
            } else {
                throw NetworkError.dataNotValid
            }
        } else {
            throw NetworkError.status(response.statusCode)
        }
    }
    #endif
}

public extension URLSession {
    func dataRequest(from url:URL) async throws -> (Data, URLResponse) {
        do {
            return try await data(from: url)
        } catch {
            throw NetworkError.general(error)
        }
    }
    
    func dataRequest(for request:URLRequest) async throws -> (Data, URLResponse) {
        do {
            return try await data(for: request)
        } catch {
            throw NetworkError.general(error)
        }
    }
}

public enum HTTPMethods:String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public extension URLRequest {
    static func get(url:URL, token:String? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        if let token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        request.httpMethod = HTTPMethods.get.rawValue
        request.timeoutInterval = 30
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
    
    static func post<JSON:Codable>(url:URL, data:JSON, method:HTTPMethods = .post, token:String? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        if let token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        request.httpMethod = method.rawValue
        request.timeoutInterval = 30
        request.setValue("application/json; charset=utf8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(data)
        return request
    }
}
