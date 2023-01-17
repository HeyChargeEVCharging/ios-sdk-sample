//
//  ChargersView.swift
//  HeyChargeiOS
//
//  Created by Muhammad Mneimneh on 13.01.2023.
//

import SwiftUI
import ios_sdk

struct ChargersView: View {
    //dummy data for ui testing
    @StateObject var viewModel = ChargersViewModel(fromChargers: [
        Charger(id: "1", name: "Garage charger", b2bId: "1", address: "1st floor", connectors: [], chargePoint: ChargePoint(firmwareVersion: "2.1", serialNumber: "234343", vendor: "chargersss"), type: .secureCharge, pricing: ChargerPricing(driverPrice: 42, heychargeMargin: 2.4, propertyMargin: 1.8, utilityPrice: 5), shouldSyncTime: true),
        Charger(id: "2", name: "Garage charger", b2bId: "1", address: "1st floor", connectors: [], chargePoint: ChargePoint(firmwareVersion: "2.1", serialNumber: "234343", vendor: "chargersss"), type: .secureCharge, pricing: ChargerPricing(driverPrice: 42, heychargeMargin: 2.4, propertyMargin: 1.8, utilityPrice: 5), shouldSyncTime: true),
        Charger(id: "3", name: "Garage charger", b2bId: "1", address: "1st floor", connectors: [], chargePoint: ChargePoint(firmwareVersion: "2.1", serialNumber: "234343", vendor: "chargersss"), type: .secureCharge, pricing: ChargerPricing(driverPrice: 42, heychargeMargin: 2.4, propertyMargin: 1.8, utilityPrice: 5), shouldSyncTime: true)
    ])
    
    var body: some View {
        NavigationView{
            List(viewModel.chargers) { charger in
                ChargerCardView(charger: charger)
            }
        }
    }
}

extension ChargersView {
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
}

struct ChargersView_Previews: PreviewProvider {
    static var previews: some View {
        ChargersView(viewModel: ChargersView.ChargersViewModel(fromChargers: [
            Charger(id: "1", name: "Garage charger", b2bId: "1", address: "1st floor", connectors: [], chargePoint: ChargePoint(firmwareVersion: "2.1", serialNumber: "234343", vendor: "chargersss"), type: .secureCharge, pricing: ChargerPricing(driverPrice: 42, heychargeMargin: 2.4, propertyMargin: 1.8, utilityPrice: 5), shouldSyncTime: true),
            Charger(id: "2", name: "Garage charger", b2bId: "1", address: "1st floor", connectors: [], chargePoint: ChargePoint(firmwareVersion: "2.1", serialNumber: "234343", vendor: "chargersss"), type: .secureCharge, pricing: ChargerPricing(driverPrice: 42, heychargeMargin: 2.4, propertyMargin: 1.8, utilityPrice: 5), shouldSyncTime: true),
            Charger(id: "3", name: "Garage charger", b2bId: "1", address: "1st floor", connectors: [], chargePoint: ChargePoint(firmwareVersion: "2.1", serialNumber: "234343", vendor: "chargersss"), type: .secureCharge, pricing: ChargerPricing(driverPrice: 42, heychargeMargin: 2.4, propertyMargin: 1.8, utilityPrice: 5), shouldSyncTime: true)

        ]))
    }
}
