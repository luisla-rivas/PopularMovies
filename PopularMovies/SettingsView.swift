//
//  SettingsView.swift
//  PopularMovies
//
//  Created by Luis Lasierra on 25/7/23.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appVM:MoviesVM
    @AppStorage("preferredColorScheme") var preferredColorScheme: Int = 0
    @AppStorage("selectedLanguage", store: .standard) var selectedLanguage: String = "en"


    
    //    @AppStorage("isOffline", store: .standard) var isOffline: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                Picker("Language", selection: $selectedLanguage) {
                    ForEach(appVM.languages) { availableLanguage in
                        HStack {
                            VStack(alignment: .trailing) {
                                Text(availableLanguage.name)
                                Text(availableLanguage.nativeName)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }.tag(availableLanguage.id)
                    }
                }.pickerStyle(.automatic)

//                Toggle(isOn: $isOffline) {
//                    Text("Mode Offline")
//                }
                
                Picker("Dark/Light mode", selection: $preferredColorScheme) {
                    Text("Automatic").tag(0)
                    Text("Light").tag(1)
                    Text("Dark").tag(2)
                }
                
            }
            .onChange(of: selectedLanguage) { selected in
                appVM.languageID = selected
                //print(appVM.languageID)
                Task { await appVM.initData() }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(MoviesVM())
    }
}
