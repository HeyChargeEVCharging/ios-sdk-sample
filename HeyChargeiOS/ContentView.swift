//
//  ContentView.swift
//  HeyChargeiOS
//
//  Created by khort on 12.10.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ChargerTabView()
                .tabItem {
                    Label("Chargers", systemImage: "bolt.circle")
                }
            HistoryView()
                .tabItem {
                    Label("History", systemImage: "calendar")
                }
            MoreView()
                .tabItem {
                    Label("More", systemImage: "ellipsis.circle")
                }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
