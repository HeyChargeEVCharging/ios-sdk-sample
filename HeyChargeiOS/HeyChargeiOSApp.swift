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
    
    init() {
        HeyChargeSDK.initialize(sdkKey: "KTrCsT64MbSBECjDejVNVKgu35n9t99G", userId: "CijZBYthXEe7cG204zBASNDJw2c2")
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
