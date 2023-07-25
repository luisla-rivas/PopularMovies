//
//  MovieDetailView.swift
//  PopularMovies
//
//  Created by Luis Lasierra on 25/7/23.
//

import SwiftUI

struct MovieDetailView: View {
    @EnvironmentObject var appVM: MoviesVM
    var vm: DetailVM
    
    var body: some View {
        ScrollView {
            if let poster = vm.poster { //, appVM.selectedMovie?.id != vm.movie.id
                Image(uiImage: poster)
                    .resizable()
                    .scaledToFit()
                    .frame(alignment: .top)
                    .cornerRadius(10)
                    .padding(5)
//                    .matchedGeometryEffect(id: "cover\(cellVM.movie.id)", in: namespace)
            } else {
                Rectangle()
                    .fill(.background)
                    .frame(width: 80)
            }
            VStack {
                Text(vm.movie.title)
                Text(vm.movie.originalTitle)
                    .font(.footnote)
                PopularityAndRateView(movie: vm.movie, showVotes: false)
                .font(.footnote)

                Text(vm.movie.overview)
                    .font(.body)
                
            }
            .padding(.horizontal)
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationStack {
            MovieDetailView(vm: DetailVM(movie: .preview))
                .environmentObject(MoviesVM.preview)
        }
    }
}
