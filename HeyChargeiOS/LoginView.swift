//
//  LoginView.swift
//  HeyChargeiOS
//
//  Created by Muhammad Mneimneh on 13.01.2023.
//

import SwiftUI

struct LoginView: View {
    @State private var userInput: String = ""
    
    var body: some View {
        NavigationView{
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
                NavigationLink(destination: HomeView(userInput: userInput)) {
                    Text("Submit")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(5)
                }
                .padding()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
