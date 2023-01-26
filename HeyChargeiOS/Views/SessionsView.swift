//
//  SessionsView.swift
//  HeyChargeiOS
//
//  Created by Muhammad Mneimneh on 13.01.2023.
//

import SwiftUI
import ios_sdk

struct SessionsView: View {
    
    @State private var pickedDate: Date = Date.now
    @StateObject var viewModel = SessionsViewModel()
    
    var body: some View {
        VStack{
            DatePicker("Select date", selection: $pickedDate, in: ...Date.now, displayedComponents: .date).onChange(of: pickedDate, perform: { newValue in
                viewModel.observeSessions(pickedDate: newValue)
            })
            .onAppear{
                viewModel.observeSessions(pickedDate: pickedDate)
            }
            .padding(8.0)
            Text("Current date is \(pickedDate.ISO8601Format())")
            List{
                ForEach(viewModel.sessions) { session in
                    SessionCardView(session: session)
                }
            }
        }
    }
}

struct SessionsView_Previews: PreviewProvider {
    static var previews: some View {
        SessionsView(viewModel: SessionsViewModel(fromSessions: [
            Session(id: "1", userId: "useId", b2bId: "b2bId", chargeAmount: 0.0, chargerId: "chargerId", chargerName: "chargerName", commercialModel: nil, createdAt: 1234567896543, deliveryDuration: 12456, endDate: 1234567896543, startDate: 1234567896543, isBilled: false, paymentAmount: 20.23, pricing: ChargerPricing(driverPrice: 0.05, heychargeMargin: 0.0, propertyMargin: 0.0, utilityPrice: 0.0)),
            Session(id: "1", userId: "useId", b2bId: "b2bId", chargeAmount: 0.0, chargerId: "chargerId", chargerName: "chargerName", commercialModel: nil, createdAt: 1234567896543, deliveryDuration: 12456, endDate: 1234567896543, startDate: 1234567896543, isBilled: false, paymentAmount: 20.23, pricing: ChargerPricing(driverPrice: 0.05, heychargeMargin: 0.0, propertyMargin: 0.0, utilityPrice: 0.0)),
            Session(id: "1", userId: "useId", b2bId: "b2bId", chargeAmount: 0.0, chargerId: "chargerId", chargerName: "chargerName", commercialModel: nil, createdAt: 1234567896543, deliveryDuration: 12456, endDate: 1234567896543, startDate: 1234567896543, isBilled: false, paymentAmount: 20.23, pricing: ChargerPricing(driverPrice: 0.05, heychargeMargin: 0.0, propertyMargin: 0.0, utilityPrice: 0.0))
        ]))
    }
}
