//
//  ViewModelWatch.swift
//  Tori's Forest for Watch App
//
//  Created by hyebin on 2023/06/13.
//

import Foundation
import WatchConnectivity

class ViewModelWatch: NSObject, WCSessionDelegate, ObservableObject {
    var session: WCSession
    @Published var messageText = [String: String]()

    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        messageText = UserDefaults.standard.array(forKey: "mission") as? [String: String] ?? ["민들레씨": "창문 30분 열어 환기하기", "???": "아침에 이불 정리하기", "????": "하루에 한 번 샤워하기"]
        session.activate()
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }

    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        DispatchQueue.main.async {
            self.messageText = message["message"] as? [String: String] ?? ["": ""]
            UserDefaults.standard.setValue(self.messageText, forKey: "mission")
        }
    }
}
