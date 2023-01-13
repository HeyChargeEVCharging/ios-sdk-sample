//
//  ChargerView.swift
//  HeyChargeiOS
//
//  Created by khort on 12.10.2022.
//

import SwiftUI
import ios_sdk

struct ChargerTabView: View {
    @StateObject var viewModel = ChargerTabViewModel()
    
    var body: some View {
        NavigationView {
//            List {
//                ForEach<[Charger], String, ChargerRowView>(viewModel.chargers) { charger in
//                    ChargerRowView(charger: charger)
//                }
//            }
        }
    }
}

struct ChargerTabView_Previews: PreviewProvider {
    static var previews: some View {
        return ChargerTabView(viewModel: ChargerTabView.ChargerTabViewModel(fromChargers: [
//            Charger(
//            id: "1",
//            name: "Access Point 1",
//            b2bId: "1",
//            address: "",
//            status: .Available,
//            type: .AccessPoint,
//            pricing: 0,
//            isNearby: true,
//            onboarded: true,
//            commercialModel: .off),
//            Charger(
//            id: "2",
//            name: "Access Point 2",
//            b2bId: "1",
//            address: "",
//            status: .NotAvailable,
//            type: .AccessPoint,
//            pricing: 0,
//            isNearby: true,
//            onboarded: true,
//            commercialModel: .off),
//            Charger(
//            id: "3",
//            name: "Wallbox 54",
//            b2bId: "1",
//            address: "",
//            status: .InUse,
//            type: .Wallbox,
//            pricing: 0,
//            isNearby: true,
//            onboarded: true,
//            commercialModel: .off),
//            Charger(
//            id: "4",
//            name: "Wallbox 86",
//            b2bId: "1",
//            address: "",
//            status: .InProgress,
//            type: .Wallbox,
//            pricing: 0,
//            isNearby: true,
//            onboarded: true,
//            commercialModel: .off),
        ]))
    }
}
