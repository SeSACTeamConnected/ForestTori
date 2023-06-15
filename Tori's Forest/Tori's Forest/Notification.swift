//
//  Notification.swift
//  Tori's Forest
//
//  Created by 김다빈 on 2023/06/13.
//

import Foundation
import UserNotifications

class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    let notificationCenter = UNUserNotificationCenter.current()
    static let shared = NotificationManager()
    
    func requestAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Notification authorization granted.")
            } else {
                print("Notification authorization denied.")
            }
        }
    }
    
    func isNotificationAuthorized() -> Bool {
        let semaphore = DispatchSemaphore(value: 0)
        var isAuthorized = false
        notificationCenter.getNotificationSettings { settings in
            isAuthorized = settings.authorizationStatus == .authorized
            semaphore.signal()
        }
        semaphore.wait()
        return isAuthorized
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "숲토리"
        content.body = "민들레꽃이 토리를 기다리고 있어요:)\n오늘 미션을 수행해서 민들레꽃을 키워보아요"
        content.sound = UNNotificationSound.default
        
        // 알림이 표시될 시각 설정
//        var dateComponents = DateComponents()
//        dateComponents.hour = 9
//        dateComponents.minute = 58
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        
        // 알림 요청 생성
        let request = UNNotificationRequest(identifier: "Notification", content: content, trigger: trigger)
        
        // 알림 예약

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Failed to schedule notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully.")
            }
        }
    }
}

