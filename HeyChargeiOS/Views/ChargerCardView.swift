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
    //charger state props
    @State private var isButtonVisible = false
    @State private var statusText = ""
    @State private var buttonText = ""
    @State private var statusColor = Color(.gray)
    //alert props
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var alertSuccess = true
    
    private let sdk = HeyChargeSDK.chargers()

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
                    .foregroundColor(statusColor)
                Spacer()
                Text(statusText)
                Spacer()
                if isButtonVisible {
                    Button(action: {
                        self.buttonClicked()
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
        .onAppear() {
            getChargerState()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")) {
                self.showAlert = false
            })
        }
    }
    
    func buttonClicked() {
        switch buttonText {
        case "Start charging":
            sdk.startCharging(charger: charger) {
                self.updateAlert(title: "Success", message: "Charging started.", success: true)
                self.getChargerState()
            } onChargingCommandFailure: { error in
                self.updateAlert(title: "Error", message: "Failed to start charging: \(error.localizedDescription)", success: false)
            }
        case "Stop charging":
            sdk.stopCharging(charger: charger) {
                self.updateAlert(title: "Success", message: "Charging stopped.", success: true)
                self.getChargerState()
            } onChargingCommandFailure: { error in
                self.updateAlert(title: "Error", message: "Failed to stop charging: \(error.localizedDescription)", success: false)
            }
        default:
            return
        }
    }
    
    func getChargerState() {
        print("charger status: " + charger.bluetoothStatus.debugDescription)
        
        if sdk.isChargerAvailable(charger: charger) {
            isButtonVisible = true
            statusText = "Available"
            buttonText = "Start charging"
            statusColor = .green
        }
        
        if sdk.isChargerBusy(charger: charger) {
            isButtonVisible = false
            statusText = "In use"
            buttonText = ""
            statusColor = .red
        }
        
        if sdk.isChargingByUser(charger: charger) {
            isButtonVisible = true
            statusText = "In use - self"
            buttonText = "Stop charging"
            statusColor = .red
        }
        
        if charger.bluetoothStatus == .notOnboarded {
            isButtonVisible = true
            statusText = ""
            buttonText = "Complete setup"
            statusColor = .gray
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
