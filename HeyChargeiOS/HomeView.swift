//
//  HomeView.swift
//  HeyChargeiOS
//
//  Created by Muhammad Mneimneh on 13.01.2023.
//

import SwiftUI
import ios_sdk

struct HomeView: View {
    var userInput: String
    
    var body: some View {
        TabView {
            ChargersView()
                .tabItem {
                    Image(systemName: "bolt.fill")
                    Text("Chargers")
                }
            SessionsView()
                .tabItem {
                    Image(systemName: "clock.fill")
                    Text("Sessions")
                }
            AdminView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Admin")
                }
        }
        .accentColor(Color.green)
        .onAppear{
            self.setUserId(userId: self.userInput)
        }
    }
    
    func setUserId(userId: String) {
        HeyChargeSDK.setUserId(userId: userId)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(userInput: "some user input")
    }
}
