//
//  AdminChargerView.swift
//  HeyChargeiOS
//
//  Created by Andrew Vitrichenko on 25.01.2023.
//

import SwiftUI
import ios_sdk

struct AdminChargerView: View ,Identifiable,Equatable{
    static func == (lhs: AdminChargerView, rhs: AdminChargerView) -> Bool {
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
        let updateAvailable = sdk.isChargerUpdateAvailable(charger: charger)
        if (onboardingRequired) {
            statusText = "Not onboarded"
            buttonText = "Complete setup"
            isButtonVisible = true
            statusColor = .blue
        } else if (updateAvailable) {
            statusText = "Update available"
            buttonText = "Update"
            isButtonVisible = true
            statusColor = .blue
        } else {
            statusText = charger.bluetoothStatus.debugDescription
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
                        self.buttonClicked(isUpdateAvailable: updateAvailable, onboardingRequired: onboardingRequired)
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
    
    func buttonClicked(isUpdateAvailable: Bool, onboardingRequired: Bool) {
        guard isUpdateAvailable || onboardingRequired else {return}
        if(isUpdateAvailable){
            sdk.startOtaUpdate(charger: charger) { error in
                //todo
            } otaCallbackOnUpdateFinished: {
                //todo
            } otaCallbackOnProgressUpdated: { progress in
                //todo
            }
        } else {
            sdk.startOnboarding(charger: charger) {
                // todo
            } onChargingCommandFailure: { error in
                // todo
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


struct AdminChargerView_Previews: PreviewProvider {
    static var previews: some View {
        AdminChargerView(
            charger: Charger(id: "1", name: "Garage charger", b2bId: "1", address: "1st floor", connectors: [], chargePoint: ChargePoint(firmwareVersion: "2.1", serialNumber: "234343", vendor: "chargersss"), type: .secureCharge, pricing: ChargerPricing(driverPrice: 42, heychargeMargin: 2.4, propertyMargin: 1.8, utilityPrice: 5), shouldSyncTime: true)
        )
    }
}
