//
//  ChargersViewModel.swift
//  HeyChargeiOS
//
//  Created by Muhammad Mneimneh on 18.01.2023.
//

import Foundation
import ios_sdk
import Combine
class ChargersViewModel: ObservableObject  {
    
    @Published private(set) var chargers: [Charger] = []
    @Published private(set) var properties: [String: String] = [:]
    @Published var selectedPropertyID: String? = nil
    
    private var chargersCancellable: AnyCancellable?
    
    init() {
        if let propertiesDict = HeyChargeSDK.chargers().getUserPropertiesCombined() {
            self.properties = propertiesDict
            self.selectedPropertyID = propertiesDict.keys.first // Select the first property ID by default
            self.selectedPropertyDidChange()
        }
    }
    
    init(fromChargers chargers: [Charger]) {
        self.chargers = chargers
    }

    
    func selectedPropertyDidChange() {
        if let selectedPropertyID = selectedPropertyID {
            HeyChargeSDK.chargers().initializeChargers(propertyId: selectedPropertyID)
            observeChargers()
        }
    }
    
    func observeChargers() {
        chargersCancellable?.cancel()
        chargersCancellable = HeyChargeSDK.chargers().observeChargers(receiveCompletion: { result in
            switch result {
            case .failure(let error): fatalError(error.localizedDescription)
            case .finished: print("finished called.")
            }
        }, receiveValue: { chargers in
            self.chargers = chargers
        })
    }
    
    deinit {
        chargersCancellable?.cancel()
    }
}
