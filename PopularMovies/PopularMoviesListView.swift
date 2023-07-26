//
//  PopularMoviesListView.swift
//  PopularMovies
//
//  Created by Luis Lasierra on 25/7/23.
//

import SwiftUI

struct PopularMoviesListView: View {
    @EnvironmentObject var appVM:MoviesVM
    
    var body: some View {
        NavigationStack {
            Group {
                if !appVM.movies.isEmpty {
                    List {
                        ForEach(appVM.movies) { movie in
                            NavigationLink(value: movie) {
                                RowView(vm: RowVM(movie: movie,
                                                  persistence: appVM.persistence))
                            }
                        }
                    }
                    .listStyle(.plain)
                    .navigationTitle("Popular movies")
                    .navigationDestination(for: MovieResult.self) { movie in
                        MovieDetailView(vm: DetailVM(movie: movie, persistence: appVM.persistence))
                    }
                    .refreshable {
                        await appVM.initData()
                    }
                } else {
                    VStack {
                        Text("There are no data to show!")
                            
                        Button {
                            appVM.loading = true
                            Task { await appVM.initData() }
                        } label: {
                            Text("Try again!")
                        }.buttonStyle(.bordered)
                    }
                    .navigationTitle("Popular movies")
                    .offset(y: -30)
                }
            }
            .alert("Network alert!",
                   isPresented: $appVM.showError) {
                Button {
                    appVM.errorMsg = ""
                    appVM.loading = false
                } label: {
                    Text("OK")
                }
            } message: {
                Text(appVM.errorMsg)
            }
        }
        .overlay {
            if appVM.loading == true {
                LoadingView()
                    .transition(.opacity)
            }
        }
        .animation(.default, value: appVM.loading)
    }
}

struct PopularMoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PopularMoviesListView()
                .environmentObject(MoviesVM.preview)
        }
    }
}
