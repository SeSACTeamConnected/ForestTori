//
//  ViewModelPhone.swift
//  Tori's Forest
//
//  Created by hyebin on 2023/06/13.
//

import Foundation
import WatchConnectivity

class ViewModelPhone: NSObject, ObservableObject, WCSessionDelegate {
    @Published var messageText = ""
    var session: WCSession

    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }

    func sessionDidBecomeInactive(_ session: WCSession) {
    }

    func sessionDidDeactivate(_ session: WCSession) {
    }

    func sendMessageToWatch(message: [String: String]) {
        guard session.isReachable else {
            print("Watch is not reachable")
            return
        }
        print("Watch is reachable")

        let messageData = ["message": message]
        session.sendMessage(messageData, replyHandler: nil) { (error) in
            print(error.localizedDescription)
        }
    }
}
