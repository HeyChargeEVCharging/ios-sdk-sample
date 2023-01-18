//
//  ChargersViewModel.swift
//  HeyChargeiOS
//
//  Created by Muhammad Mneimneh on 18.01.2023.
//

import Foundation
import ios_sdk
@MainActor class ChargersViewModel: ObservableObject  {
    @Published private(set) var chargers: [Charger] = []
        
    init() {
            
    }
        
    init(fromChargers chargers: [Charger]) {
        self.chargers = chargers
    }
        
    func observeChargers() {
        HeyChargeSDK.chargers().observeChargers { error in
            fatalError(error.localizedDescription)
        } onGetDataSuccess: { chargersList in
            self.chargers = chargersList
        }
    }
}
