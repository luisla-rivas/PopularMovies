//
//  Configuration.swift
//  PopularMovies
//
//  Created by Luis Lasierra on 25/7/23.
//

import Foundation
//import BC2023Network
import Combine

final class Configuration {
    static let shared = Configuration()

    var configuration:ConfigurationAPI!
    let subject = PassthroughSubject<Bool, Never>()
    init() {
        Task {
            do {
                try await Task.sleep(for: .seconds (1))
                self.configuration = try await getConfiguration()
                subject.send(true)
            } catch {
                print (error)
            }
            
            func getConfiguration() async throws -> ConfigurationAPI {
                try await Network.shared.getJSON(request: .get(url: .getConfiguration, token: APIKEY),
                                                    type: ConfigurationAPI.self)
            }
        }
    }
}
