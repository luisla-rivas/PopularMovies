//
//  Extensions.swift
//  PopularMovies
//
//  Created by Luis Lasierra on 25/7/23.
//

import Foundation

extension DateFormatter {
    static let formato:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}

extension JSONDecoder {
    static let decoderWithDate = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.formato)
        return decoder
    }()
}
