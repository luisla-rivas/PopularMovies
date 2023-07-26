//
//  RowView.swift
//  PopularMovies
//
//  Created by Luis Lasierra on 25/7/23.
//

import SwiftUI

struct RowView: View {
    @EnvironmentObject var appVM:MoviesVM
    @ObservedObject var vm:RowVM
    //let namespace:Namespace.ID
    
    var body: some View {
        HStack {
            if let poster = vm.poster { //, appVM.selectedMovie?.id != vm.movie.id
                Image(uiImage: poster)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80)
                    .frame(alignment: .topLeading)
                    .cornerRadius(10)
//                    .padding(5)
//                    .matchedGeometryEffect(id: "cover\(cellVM.movie.id)", in: namespace)
            } else {
                Rectangle()
                    .fill(.background)
                    .frame(width: 80)
            }
            VStack(alignment: .leading) {
                Text(vm.movie.title)
                Text(vm.movie.originalTitle)
                    .font(.footnote)
                Spacer()
                PopularityAndRateView(movie: vm.movie, showVotes: false)
                .font(.footnote)
            }
        }
        .frame(height: 100)
        //
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(vm: RowVM(movie: .preview, persistence: PersistencePreview.shared))
            .environmentObject(MoviesVM.preview)
            .padding(.horizontal)
    }
}
