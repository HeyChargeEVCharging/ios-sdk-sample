//
//  SessionsViewModel.swift
//  HeyChargeiOS
//
//  Created by Andrew Vitrichenko on 25.01.2023.
//

import Foundation
import ios_sdk
import Combine
class SessionsViewModel: ObservableObject  {
    
    @Published private(set) var sessions: [Session] = []
    
    private var sessionsCancellable: AnyCancellable?
    
    init(){}
    
    init(fromSessions sessions: [Session]) {
        self.sessions = sessions
    }
    
    func observeSessions(pickedDate: Date) {
        let startDateInMillis = Int(pickedDate.timeIntervalSince1970 * 1000)
        sessionsCancellable?.cancel()
        sessionsCancellable = HeyChargeSDK.sessions().observeSessions(startDateInMillis:startDateInMillis,receiveCompletion: { result in
            switch result {
            case .failure(let error): fatalError(error.localizedDescription)
            case .finished: print("finished called.")
            }
        }, receiveValue: { sessions in
            self.sessions = sessions
        })
    }
    
    deinit {
        sessionsCancellable?.cancel()
    }
}
