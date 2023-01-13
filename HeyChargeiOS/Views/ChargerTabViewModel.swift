//
//  ChargerTabViewModel.swift
//  HeyChargeiOS
//
//  Created by khort on 16.10.2022.
//

import SwiftUI
import ios_sdk

extension ChargerTabView {
    @MainActor class ChargerTabViewModel: ObservableObject  {
        @Published private(set) var chargers: [Charger] = []
//        private(set) var chargerObserver: HCObserver?
        
        init() {
//            chargerObserver = HeyChargeSDK.chargers().observeChargers(
//                onError: { error in print("Error during observing chargers")},
//                onChange: { hcChargers in self.chargers = hcChargers})
        }
        
        init(fromChargers chargers: [Charger]) {
            self.chargers = chargers
        }
        
        func startCharging() {
            
        }
        
        func stopCharging() {
            
        }
    }
}
