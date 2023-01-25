//
//  ChargersViewModel.swift
//  HeyChargeiOS
//
//  Created by Muhammad Mneimneh on 18.01.2023.
//

import Foundation
import ios_sdk
class ChargersViewModel: ObservableObject, GetDataCallbackProtocol  {
    typealias T = [Charger]
    
    @Published private(set) var chargers: [Charger] = []
        
    init() {
        observeChargers()
    }
        
    init(fromChargers chargers: [Charger]) {
        self.chargers = chargers
    }
        
    func observeChargers() {
        HeyChargeSDK.chargers().observeChargers(callback: self)
    }
    
    func onGetDataSuccess(data: [ios_sdk.Charger]) {
        self.chargers = data
    }
    
    func onGetDataFailure(exception: ios_sdk.SDKError) {
        fatalError(exception.localizedDescription)
    }
}
