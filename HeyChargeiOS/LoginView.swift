//
//  LoginView.swift
//  HeyChargeiOS
//
//  Created by Muhammad Mneimneh on 13.01.2023.
//

import SwiftUI
import ios_sdk

struct LoginView: View {
    @State private var userInput: String = ""
    @State private var readyToNavigate: Bool = false
    var body: some View {
        NavigationStack{
            VStack {
                TextField("Enter your user Id here", text: $userInput)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.green, lineWidth: 2)
                    )
                    .padding()
                Button(action: {
                    self.submit()
                }) {
                    Text("Submit")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(5)
                }
            .padding()
        }
        .navigationTitle("iOS SDK testing")
        .navigationDestination(isPresented: $readyToNavigate) {
            HomeView()
        }
    }
}
    
    func submit() {
        HeyChargeSDK.setUserId(userId: userInput)
        self.readyToNavigate = true
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
