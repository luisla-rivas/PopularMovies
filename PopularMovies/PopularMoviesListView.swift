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
                                RowView(vm: RowVM(movie: movie))
                            }
                        }

                    }
                    .listStyle(.plain)
                    .navigationTitle("Popular movies")
                    .navigationDestination(for: MovieResult.self) { movie in
                        MovieDetailView(vm: DetailVM(movie: movie))
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
        PopularMoviesListView()
            .environmentObject(MoviesVM())
    }
}
