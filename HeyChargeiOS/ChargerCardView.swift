//
//  ChargerCardView.swift
//  HeyChargeiOS
//
//  Created by Muhammad Mneimneh on 13.01.2023.
//

import SwiftUI

struct ChargerCardView: View {
    var name: String
    var location: String
    var pricing: Double
    var state: String

    @State private var isRunning = false

    var body: some View {
        VStack(alignment: .leading) {
            Text(name)
                .font(.headline)
                .foregroundColor(.green)
            Text(location)
                .font(.subheadline)
                .italic()
                .foregroundColor(.green)
            HStack {
                Text("$\(pricing)")
                    .font(.subheadline)
                    .foregroundColor(.green)
                Spacer()
            }
            HStack {
                Circle()
                    .frame(width: 20, height: 20)
                    .foregroundColor(stateColor)
                Spacer()
                if state == "idle" {
                    Button(action: {
                        self.isRunning.toggle()
                    }) {
                        Text(isRunning ? "Stop" : "Start")
                            .foregroundColor(.white)
                            .padding(.all, 10)
                            .background(isRunning ? Color.red : Color.green)
                            .cornerRadius(5)
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.green, lineWidth: 2))
    }
    var stateColor: Color {
        switch state {
            case "idle":
                return .green
            case "offline":
                return .red
            case "busy":
                return .yellow
            default:
                return .gray
        }
    }
}


struct ChargerCardView_Previews: PreviewProvider {
    static var previews: some View {
        ChargerCardView(name: "Garage charger", location: "1st floor", pricing: 32, state: "idle")
    }
}
