//
//  ChargerCardView.swift
//  HeyChargeiOS
//
//  Created by Muhammad Mneimneh on 13.01.2023.
//

import SwiftUI
import ios_sdk

struct ChargerCardView: View {
    var charger: Charger
    
    @State private var isButtonVisible = false

    var body: some View {
        VStack(alignment: .leading) {
            Text(charger.name)
                .font(.headline)
                .foregroundColor(.green)
            Text(charger.address)
                .font(.subheadline)
                .italic()
                .foregroundColor(.green)
            HStack {
                Text("$\(charger.pricing.driverPrice)")
                    .font(.subheadline)
                    .foregroundColor(.green)
                Spacer()
            }
            HStack {
                Circle()
                    .frame(width: 20, height: 20)
                    .foregroundColor(getChargerState().color)
                Spacer()
                if isButtonVisible {
                    Button(action: {
                        //
                    }) {
                        Text(getChargerState().buttonText)
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.green, lineWidth: 2))
    }
    
    func getChargerState() -> (statusText: String, buttonText: String, color:  Color) {
        if HeyChargeSDK.chargers().isChargerAvailable(charger: charger) {
            isButtonVisible = true
            return ("Available", "Start charging", .green)
        }
        
        if
            HeyChargeSDK.chargers().isChargerBusy(charger: charger) {
            isButtonVisible = false
            return ("In use", "", .red)
        }
        
        if HeyChargeSDK.chargers().isChargingByUser(charger: charger) {
            isButtonVisible = true
            return ("In use - self", "Stop charging", .red)
        }
        
        if charger.bluetoothStatus == .notOnboarded {
            isButtonVisible = true
            return ("", "Complete setup", .gray)
        }
        
        return ("", "", .gray)
        
    }
}


struct ChargerCardView_Previews: PreviewProvider {
    static var previews: some View {
        ChargerCardView(
            charger: Charger(id: "1", name: "Garage charger", b2bId: "1", address: "1st floor", connectors: [], chargePoint: ChargePoint(firmwareVersion: "2.1", serialNumber: "234343", vendor: "chargersss"), type: .secureCharge, pricing: ChargerPricing(driverPrice: 42, heychargeMargin: 2.4, propertyMargin: 1.8, utilityPrice: 5), shouldSyncTime: true)
        )
    }
}
