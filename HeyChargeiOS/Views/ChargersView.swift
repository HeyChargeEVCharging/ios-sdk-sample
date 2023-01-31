//
//  ChargersView.swift
//  HeyChargeiOS
//
//  Created by Muhammad Mneimneh on 13.01.2023.
//

import SwiftUI
import ios_sdk

struct ChargersView: View {
    
    var isAdminTab = false
    @StateObject var viewModel = ChargersViewModel()
    
    @ViewBuilder
    var body: some View {
            List{
                ForEach(viewModel.chargers) { charger in
                    if(isAdminTab){
                        AdminChargerView(charger: charger)
                    } else {
                        ChargerCardView(charger: charger)
                    }
                }
        }
    }
}

struct ChargersView_Previews: PreviewProvider {
    static var previews: some View {
        ChargersView(isAdminTab:false,viewModel: ChargersViewModel(fromChargers: [
            Charger(id: "1", name: "Garage charger", b2bId: "1", address: "1st floor", connectors: [], chargePoint: ChargePoint(firmwareVersion: "2.1", serialNumber: "234343", vendor: "chargersss"), type: .secureCharge, pricing: ChargerPricing(driverPrice: 42, heychargeMargin: 2.4, propertyMargin: 1.8, utilityPrice: 5), shouldSyncTime: true),
            Charger(id: "2", name: "Garage charger", b2bId: "1", address: "1st floor", connectors: [], chargePoint: ChargePoint(firmwareVersion: "2.1", serialNumber: "234343", vendor: "chargersss"), type: .secureCharge, pricing: ChargerPricing(driverPrice: 42, heychargeMargin: 2.4, propertyMargin: 1.8, utilityPrice: 5), shouldSyncTime: true),
            Charger(id: "3", name: "Garage charger", b2bId: "1", address: "1st floor", connectors: [], chargePoint: ChargePoint(firmwareVersion: "2.1", serialNumber: "234343", vendor: "chargersss"), type: .secureCharge, pricing: ChargerPricing(driverPrice: 42, heychargeMargin: 2.4, propertyMargin: 1.8, utilityPrice: 5), shouldSyncTime: true)
            
        ]))
    }
}
