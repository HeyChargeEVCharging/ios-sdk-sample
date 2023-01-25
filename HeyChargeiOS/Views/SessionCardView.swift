//
//  SessionCardView.swift
//  HeyChargeiOS
//
//  Created by Andrew Vitrichenko on 25.01.2023.
//

import SwiftUI
import ios_sdk

struct SessionCardView: View ,Identifiable,Equatable{
    static func == (lhs: SessionCardView, rhs: SessionCardView) -> Bool {
        lhs.session == rhs.session
    }
    
    private let session: Session
    internal let id: String
    private let df = DateFormatter()
    
    init(session: Session) {
        self.session = session
        self.id = session.id
        df.dateFormat = "y-MM-dd H:mm:ss"
    }
    
    var body: some View {
        let dateObject = Date(timeIntervalSince1970: TimeInterval(session.endDate) / 1000)
        let date = df.string(from: dateObject)
        let chargeAmount = String(format: "%.2f", (session.chargeAmount / 1000))
        VStack(alignment: .leading) {
            Text(session.chargerName)
                .font(.headline)
                .foregroundColor(.green)
            Text(date)
                .font(.subheadline)
                .italic()
                .foregroundColor(.green)
            Text(chargeAmount)
                .font(.subheadline)
                .italic()
                .foregroundColor(.green)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.green, lineWidth: 2))
    }
    
}


struct SessionCardView_Previews: PreviewProvider {
    static var previews: some View {
        SessionCardView(session: Session(id: "1", userId: "useId", b2bId: "b2bId", chargeAmount: 0.0, chargerId: "chargerId", chargerName: "chargerName", commercialModel: nil, createdAt: 1234567896543, deliveryDuration: 12456, endDate: 1234567896543, startDate: 1234567896543, isBilled: false, paymentAmount: 20.23, pricing: ChargerPricing(driverPrice: 0.05, heychargeMargin: 0.0, propertyMargin: 0.0, utilityPrice: 0.0)))
    }
}
