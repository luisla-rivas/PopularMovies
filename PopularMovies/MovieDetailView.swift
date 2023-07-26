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
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal, 40)
//                    .matchedGeometryEffect(id: "cover\(cellVM.movie.id)", in: namespace)
            } else {
                Image(systemName: "popcorn")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150  ,height: 200)
                    .padding()
                    .background(Color.secondary)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            VStack(alignment: .center) {
                Text(vm.movie.title)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                Text(vm.movie.originalTitle)
                    .font(.headline)
                    .foregroundColor(.secondary)
                PopularityAndRateView(movie: vm.movie, showVotes: false).padding(.vertical)
                    .font(.footnote)
            }.padding(.horizontal)
            VStack(alignment: .leading) {
                Text(vm.movie.overview)
                    .font(.body)
                
            }
            .padding(.horizontal)
        }
        .toolbar(.hidden, for: .tabBar)
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
