//
//  ViewController.swift
//  UnUserNotificationCenter
//
//  Created by Jeongguk Kim on 2021/02/19.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scheduleNotification()
        
    }
    func scheduleNotification() { //알람생성 후 추가
        let notificationCenter = UNUserNotificationCenter.current()
        
        let notification = UNMutableNotificationContent() // 알람 인스턴스생성
        notification.title = "title"
        notification.body = "body"
        notification.categoryIdentifier = "category"
        notification.userInfo = ["additionalData": "Additional data can also be provided"]
        notification.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents() //특정 시간을 정해서 알람을 설정할 때 사용
        dateComponents.hour = 8
        dateComponents.minute = 0
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false) // timeinterval 에 dateComponents를 넣어줌
        
        let notificationRequest = UNNotificationRequest(identifier: UUID().uuidString, content: notification, trigger: trigger)
        
        notificationCenter.add(notificationRequest)
        
        
//        앱이 백그라운드에서 실행 중이거나 전혀 실행되지 않을 때만 사용자에게 표시됩니다.
    }
}
extension UIViewController: UNUserNotificationCenterDelegate {
//    앱이 foreground에서 실행될 때 로컬 알림이 사용자에게 표시되도록하려면 UNUserNotificationCenterDelegate 의 함수 중 하나를 구현해야합니다. 바로 밑에 함수
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Swift.Void) {
        completionHandler( [.badge, .sound])
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        if let additionalData = userInfo["additionalData"] as? String {
            print("Additional data: \(additionalData)")
        }
        
        switch response.actionIdentifier {
        case UNNotificationDefaultActionIdentifier:
            print("User tapped on message itself rather than on an Action button") // 알람을 클릭하면 실행됨
            
        default:
            break
        }
        
        completionHandler()
    }
 
}



