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
    var properties: [Property] = []
    var selectedPropertyID: String? = nil
    
    private var chargersCancellable: AnyCancellable?
    
    init() {
        Task {
                if let propertiesList = await HeyChargeSDK.chargers().getUserProperties(){
                    self.properties = propertiesList
                    self.selectedPropertyID = propertiesList.first?.id // Select the first property ID by default
                    self.selectedPropertyDidChange()
                }
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
            DispatchQueue.main.async { // Switch to the main thread before updating the @Published property
                self.chargers = chargers
            }
        })
    }
    
    deinit {
        chargersCancellable?.cancel()
    }
}
