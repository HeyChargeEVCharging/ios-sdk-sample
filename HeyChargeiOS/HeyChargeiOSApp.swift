//
//  HeyChargeiOSApp.swift
//  HeyChargeiOS
//
//  Created by khort on 12.10.2022.
//

import SwiftUI
import ios_sdk

@main
struct HeyChargeiOSApp: App {
    //dev
    private let testSdkKey = "KTrCsT64MbSBECjDejVNVKgu35n9t99G"
    
    @Environment(\.scenePhase) var scenePhase
    
    init() {
        HeyChargeSDK.initialize(sdkKey: testSdkKey)
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                print("Active")
            } else if newPhase == .inactive {
                print("Inactive")
            } else if newPhase == .background {
                print("Background")
            }
        }
    }
}
