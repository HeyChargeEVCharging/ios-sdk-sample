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
        Task {
            if let propertiesDict = await getUserProperties() {
                DispatchQueue.main.async {
                    self.properties = propertiesDict
                    self.selectedPropertyID = propertiesDict.keys.first // Select the first property ID by default
                    self.selectedPropertyDidChange()
                }
            }
        }
    }
    
    init(fromChargers chargers: [Charger]) {
        self.chargers = chargers
    }
    

    func getUserProperties() async -> [String: String]? {
        do {
            guard let user = try await HeyChargeSDK.users().getCurrentUser() else {
                return nil
            }
                
            var propertiesDict: [String: String] = [:]

            for adminProp in user.adminProperties ?? [] {
                propertiesDict[adminProp.id] = adminProp.name
            }
                
            for prop in user.properties {
                propertiesDict[prop.id] = prop.name
            }
                
            return propertiesDict
        }
        catch {
            // Handle specific errors here if needed
            print("Error fetching user properties: \(error)")
        }
        return nil
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
