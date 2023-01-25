//
//  ChargerCardView.swift
//  HeyChargeiOS
//
//  Created by Muhammad Mneimneh on 13.01.2023.
//

import SwiftUI
import ios_sdk

struct ChargerCardView: View ,Identifiable,Equatable{
    static func == (lhs: ChargerCardView, rhs: ChargerCardView) -> Bool {
        lhs.charger == rhs.charger
    }
    
    private let sdk = HeyChargeSDK.chargers()
    private let charger: Charger
    internal let id: String
    
    init(charger: Charger) {
        self.charger = charger
        self.id = charger.id
    }
    
    //alert props
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var alertSuccess = true
    
    var body: some View {
        var buttonText = "Not available"
        var statusText = "Not in range"
        var isButtonVisible = false
        var statusColor: Color = .gray
        let onboardingRequired = charger.bluetoothStatus == ChargerState.notOnboarded
        let isChargerAvailable = sdk.isChargerAvailable(charger: charger)
        let isChargingByUser = sdk.isChargingByUser(charger: charger)
        if (isChargerAvailable) {
            buttonText = "Star charging"
            statusText = "Available"
            isButtonVisible = true
            statusColor = .green
        }
        if (sdk.isChargerBusy(charger: charger)) {
            statusText = "In use"
        }
        if (isChargingByUser) {
            buttonText = "Stop charging"
            statusText = "In use - self"
            isButtonVisible = true
            statusColor = .red
        }
        if (onboardingRequired) {
            statusText = "Not onboarded"
            buttonText = "For admins only"
            isButtonVisible = false
        }
        return VStack(alignment: .leading) {
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
                    .foregroundColor(statusColor)
                Spacer()
                Text(statusText)
                Spacer()
                if isButtonVisible {
                    Button(action: {
                        self.buttonClicked(isAvailable: isChargerAvailable, isChargingByUser: isChargingByUser)
                    }) {
                        Text(buttonText)
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.green, lineWidth: 2))
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")) {
                self.showAlert = false
            })
        }
    }
    
    func buttonClicked(isAvailable: Bool, isChargingByUser: Bool) {
        guard isAvailable || isChargingByUser else {return}
        if(isAvailable){
            sdk.startCharging(charger: charger) {
                self.updateAlert(title: "Success", message: "Charging started.", success: true)
            } onChargingCommandFailure: { error in
                self.updateAlert(title: "Error", message: "Failed to start charging: \(error.localizedDescription)", success: false)
            }
        } else {
            sdk.stopCharging(charger: charger) {
                self.updateAlert(title: "Success", message: "Charging stopped.", success: true)
            } onChargingCommandFailure: { error in
                self.updateAlert(title: "Error", message: "Failed to stop charging: \(error.localizedDescription)", success: false)
            }
        }
    }
    
    func updateAlert(title: String, message: String, success: Bool) {
        self.alertTitle = title
        self.alertMessage = message
        self.alertSuccess = success
        self.showAlert = true
    }
    
}


struct ChargerCardView_Previews: PreviewProvider {
    static var previews: some View {
        ChargerCardView(
            charger: Charger(id: "1", name: "Garage charger", b2bId: "1", address: "1st floor", connectors: [], chargePoint: ChargePoint(firmwareVersion: "2.1", serialNumber: "234343", vendor: "chargersss"), type: .secureCharge, pricing: ChargerPricing(driverPrice: 42, heychargeMargin: 2.4, propertyMargin: 1.8, utilityPrice: 5), shouldSyncTime: true)
        )
    }
}
