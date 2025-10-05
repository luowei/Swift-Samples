//
//  AppDelegate.swift
//  iOS10Notification
//
//  Created by luowei on 2016/11/8.
//  Copyright © 2016年 wodedata. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let notificationHandler = NotificationHandler()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        registerNotificationCategory()  //注册几个Category
        UNUserNotificationCenter.current().delegate = notificationHandler
        
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenString = deviceToken.hexString
        UserDefaults.standard.set(tokenString, forKey: "push-token")
        NotificationCenter.default.post(name: .TokenName, object: nil, userInfo: ["token": tokenString])
        
        print("Get Push token: \(tokenString)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        UserDefaults.standard.set("", forKey: "push-token")
    }
    
    
    //注册几个Category
    private func registerNotificationCategory() {
        
        let saySomethingCategory: UNNotificationCategory = {
            
            let inputAction = UNTextInputNotificationAction(
                identifier: "input",
                title: "请输入",
                options: [.foreground],
                textInputButtonTitle: "发送",
                textInputPlaceholder: "说点什么吧...")
            
            let cancelAction = UNNotificationAction(
                identifier: "none",
                title: "取消",
                options: [.destructive])
            
            return UNNotificationCategory(identifier: "saySomething", actions: [inputAction, cancelAction], intentIdentifiers: [], options: [.customDismissAction])
        }()
        
        let customUICategory: UNNotificationCategory = {
            let nextAction = UNNotificationAction(
                identifier: "switch",
                title: "切换",
                options: [])
            let openAction = UNNotificationAction(
                identifier: "open",
                title: "打开",
                options: [.foreground])
            let dismissAction = UNNotificationAction(
                identifier: "dismiss",
                title: "关掉",
                options: [.destructive])
            return UNNotificationCategory(identifier: "customUI", actions: [nextAction, openAction, dismissAction], intentIdentifiers: [], options: [])
        }()
        
        UNUserNotificationCenter.current().setNotificationCategories([saySomethingCategory, customUICategory])
    }


}


extension Notification.Name {
    static let TokenName = Notification.Name(rawValue: "AppDidReceivedRemoteNotificationDeviceToken")
}

extension Data {
    var hexString: String {
        return withUnsafeBytes {(bytes: UnsafePointer<UInt8>) -> String in
            let buffer = UnsafeBufferPointer(start: bytes, count: count)
            return buffer.map {String(format: "%02hhx", $0)}.reduce("", { $0 + $1 })
        }
    }
}

