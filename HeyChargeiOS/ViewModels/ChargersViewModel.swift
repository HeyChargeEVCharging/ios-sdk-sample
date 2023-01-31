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
    
    private var chargersCancellable: AnyCancellable?
    
    init() {
        observeChargers()
    }
    
    init(fromChargers chargers: [Charger]) {
        self.chargers = chargers
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
