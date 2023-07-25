//
//  PopularityAndRateView.swift
//  PopularMovies
//
//  Created by Luis Lasierra on 25/7/23.
//

import SwiftUI

struct PopularityAndRateView: View {
    let movie: MovieResult
    let showVotes: Bool
    var body: some View {
        VStack {
            HStack {
                Text("Popularity:")
                Text("\(movie.popularity, specifier: "%.0f")")
                Spacer()
                Text("⭑").font(.title2).foregroundColor(.yellow).offset(x: 3, y: -2)
                Text("\(movie.voteAverage, specifier: "%.1f") / 10")
                }
            if showVotes {
                HStack {
                    Spacer()
                    Text("Votes:")
                    Text("\(movie.voteCount, specifier: "%.0d")")
                }.foregroundColor(.secondary)
            }
        }
    }
}

struct PopularityAndRateView_Previews: PreviewProvider {
    static var previews: some View {
        PopularityAndRateView(movie: .preview,
                              showVotes: true)
            .padding(.horizontal)
            .previewLayout(.fixed(width: 390, height: 50))
    }
}
