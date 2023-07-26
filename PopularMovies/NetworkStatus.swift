//
//  NetworkStatus.swift
//  PopularMovies
//
//  Created by Luis Lasierra on 26/7/23.
//

import SwiftUI
import Network

final class NetworkStatus:ObservableObject {
    enum Status {
        case offline, online, unknown
    }
    
    @Published var status:Status = .unknown
    
    var monitor:NWPathMonitor
    var queue = DispatchQueue(label: "MonitorNETWORK")
    
    init() {
        monitor = NWPathMonitor()
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.status = path.status == .satisfied ? .online : .offline
            }
        }
        status = monitor.currentPath.status == .satisfied ? .online : .offline
    }
}
