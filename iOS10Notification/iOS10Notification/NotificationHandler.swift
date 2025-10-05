//
//  NotificationHandler.swift
//  Swift-Samples
//
//  Created by luowei on 2016/11/8.
//  Copyright © 2016年 wodedata. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationHandler: NSObject, UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        let options: UNNotificationPresentationOptions = [.alert, .sound]

        completionHandler(options)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        
        
        let category = response.notification.request.content.categoryIdentifier
        switch category {
        case let c where c == "saySomething":
            let text: String
            
            switch response.actionIdentifier {
            case let action where action == "input":
                text = (response as? UNTextInputNotificationResponse)?.userText ?? ""
            default:
                text = ""
            }
            
            if !text.isEmpty {
                UIAlertController.showConfirmAlertFromTopViewController(message: "你刚才发送了 - \(text)")
            }
            
         case let c where c == "customUI":
            print(response.actionIdentifier)
            
        default:
            break
            
        }
        
        completionHandler()
    }

}


extension UIAlertController {
    static func showConfirmAlert(message: String, in viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        viewController.present(alert, animated: true)
    }
    
    static func showConfirmAlertFromTopViewController(message: String) {
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            showConfirmAlert(message: message, in: vc)
        }
    }
}

func delay(_ timeInterval: TimeInterval, _ block: @escaping ()->Void) {
    let after = DispatchTime.now() + timeInterval
    DispatchQueue.main.asyncAfter(deadline: after, execute: block)
}
