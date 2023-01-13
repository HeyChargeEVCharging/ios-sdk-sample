//
//  ChargersView.swift
//  HeyChargeiOS
//
//  Created by Muhammad Mneimneh on 13.01.2023.
//

import SwiftUI
import ios_sdk

struct ChargersView: View {
    
    var body: some View {
        Text("Chargers")
            .foregroundColor(Color.green)
    }
}

extension ChargersView {
    @MainActor class ChargersViewModel: ObservableObject  {
        @Published private(set) var chargers: [Charger] = []
        init() {
            HeyChargeSDK.chargers().observeChargers { error in
                fatalError(error.localizedDescription)
            } onGetDataSuccess: { chargersList in
                self.chargers = chargersList
            }

        }
        init(fromChargers chargers: [Charger]) {
            self.chargers = chargers
        }
    }
}

struct ChargersView_Previews: PreviewProvider {
    static var previews: some View {
        ChargersView()
    }
}
