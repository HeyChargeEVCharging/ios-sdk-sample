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
  
    @Environment(\.scenePhase) var scenePhase
    
    init() {
        try? HeyChargeSDK.initialize(sdkKey: "Insert sdk key here",region: HeyChargeRegion.eu)
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                HeyChargeSDK.applicationWillEnterForeground()
            } else if newPhase == .background {
                HeyChargeSDK.applicationDidEnterBackground()
            }
        }
    }
}
