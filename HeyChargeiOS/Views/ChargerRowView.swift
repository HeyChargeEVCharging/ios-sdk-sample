//
//  ChargerView.swift
//  HeyChargeiOS
//
//  Created by khort on 12.10.2022.
//

import SwiftUI
import ios_sdk

struct ChargerRowView: View {
    var charger: HCCharger
    
    var body: some View {
        HStack {
            VStack (alignment: .leading, spacing: 10) {
                HStack {
                    switch charger.status {
                    case .Available:
                        Image(systemName: "circle.fill").foregroundColor(.green)
                        Text("available").foregroundColor(.gray).font(.footnote)
                    case .InProgress:
                        Image(systemName: "bolt.fill").foregroundColor(.green)
                        Text("charging").foregroundColor(.gray).font(.footnote)
                    case .InUse:
                        Image(systemName: "bolt.circle").foregroundColor(.yellow)
                        Text("in use").foregroundColor(.gray).font(.footnote)
                    case .NotAvailable:
                        Image(systemName: "bolt.circle").foregroundColor(.gray)
                        Text("out of range").foregroundColor(.gray).font(.footnote)
                    default:
                        Image(systemName: "bolt.circle").foregroundColor(.black)
                        Text("Available").foregroundColor(.gray).font(.footnote)
                    }
                    
                }
                HStack {
                    Text(charger.name)
                }
            }
            Spacer()
            VStack {
                switch charger.status {
                case .Available:
                    Button("START") {
                    
                    }
                    .padding(.all)
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
                    .font(.footnote)
                    .background(Color(red: 0.549, green: 0.776, blue: 0.247))
                    .clipShape(Capsule(style: .circular))
                case .InProgress:
                    Button("STOP") {
                        
                    }
                    .padding(.all)
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
                    .font(.footnote)
                    .background(Color(red: 0.783, green: 0.327, blue: 0.327))
                    .clipShape(Capsule(style: .circular))
                case .InUse:
                    Button(action: doNothing) {
                        Label("CHARGE", systemImage: "slash.circle")
                    }
                    .padding(.all)
                    .foregroundColor(Color.gray)
                    .fontWeight(.bold)
                    .font(.footnote)
                    .clipShape(Capsule(style: .circular))
                case .NotAvailable:
                    Button(action: doNothing) {
                        Label("CHARGE", systemImage: "slash.circle")
                    }
                    .padding(.all)
                    .foregroundColor(Color.gray)
                    .fontWeight(.bold)
                    .font(.footnote)
                    .clipShape(Capsule(style: .circular))
                default:
                    Image(systemName: "bolt.circle").foregroundColor(.black)
                    Text("Available").foregroundColor(.gray)
                }

            }
        }
        .padding(.horizontal)

    }
    
    func doNothing() {
        
    }
}

struct ChargerRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ChargerRowView(charger: HCCharger(
                id: "1",
                name: "Access Point 1",
                b2bId: "1",
                address: "",
                status: .Available,
                type: .AccessPoint,
                pricing: 0,
                isNearby: true,
                onboarded: true,
                commercialModel: .off
            ))
            ChargerRowView(charger: HCCharger(
                id: "2",
                name: "Wallbox 54",
                b2bId: "1",
                address: "",
                status: .NotAvailable,
                type: .AccessPoint,
                pricing: 0,
                isNearby: true,
                onboarded: true,
                commercialModel: .off
            ))
        }
    }
}
