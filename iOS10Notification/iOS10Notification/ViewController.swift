//
//  ViewController.swift
//  iOS10Notification
//
//  Created by luowei on 2016/11/8.
//  Copyright © 2016年 wodedata. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    @IBOutlet weak var tokenLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    
    
    var deviceToken: String? {
        didSet {
            if isViewLoaded {
                updateUI()
            }
        }
    }
    var settings: UNNotificationSettings? {
        didSet {
            if isViewLoaded {
                updateUI()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //UNUserNotificationCenter.current().getNotificationSettings { self.settings = $0 }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(updateNotificationToken), name: .TokenName, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
        super.viewDidDisappear(animated)
    }
    
    @objc private func updateNotificationToken(notification: Notification) {
        self.deviceToken = notification.userInfo?["token"] as? String
    }
    
    private func updateUI() {
        self.tokenLabel.text = "token:\(self.deviceToken ?? "")"
        guard let settings = settings else { return }
        
        self.settingsLabel.text = "settings: NotificationCenter:\(settings.notificationCenterSetting.description),  sound:\(settings.soundSetting.description),  badge:\(settings.badgeSetting.description),  lockScreen:\(settings.lockScreenSetting.description),  alert:\(settings.alertSetting.description),  carPlay:\(settings.carPlaySetting.description),  alertStyle:\(settings.alertStyle.description)"
    }

    //请求授权
    @IBAction func requestAuthorization(_ sender: UIButton) {
        UNUserNotificationCenter.current().getNotificationSettings { self.settings = $0 }
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            granted, error in
            if granted {
                UIApplication.shared.registerForRemoteNotifications()
            } else {
                if let error = error {
                    UIAlertController.showConfirmAlert(message: error.localizedDescription, in: self)
                }
            }
        }
        
    }
    
    @IBAction func handleNotification(_ sender: UIButton) {
        let content = UNMutableNotificationContent()
        content.body = "请随便说点什么"
        
        content.categoryIdentifier = "saySomething"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let request = UNNotificationRequest(identifier: "contentAction", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        
    }

    @IBAction func customUI(_ sender: UIButton) {
        let content = UNMutableNotificationContent()
        content.title = "图片通知"
        content.body = "给我展示一些图片吧！"
        
        let attachments = ["aaa","bbb"].flatMap { name -> UNNotificationAttachment? in
            if let imageURL = Bundle.main.url(forResource: name, withExtension: "jpg") {
                return try? UNNotificationAttachment(identifier: "image-\(name)", url: imageURL, options: nil)
            }
            return nil
        }
        content.attachments = attachments
        content.userInfo = ["items": [["title": "iOS开发系列", "text": "这是iOS开发系列知识相关介绍。"], ["title": "敬请期待", "text": "下期节目，您老人家敬请期待。"]]]
        content.categoryIdentifier = "customUI"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: "imageAction", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                UIAlertController.showConfirmAlert(message: error.localizedDescription, in: self)
            } else {
                print("Customized UI Notification scheduled: imageAction")
            }
        }
        
    }

}



extension UNNotificationSetting: CustomStringConvertible {
    public var description: String {
        switch self {
        case .notSupported: return "Not Supported"
        case .disabled: return "Disabled"
        case .enabled: return "Enabeld"
        }
    }
}

extension UNAlertStyle: CustomStringConvertible {
    public var description: String {
        switch self {
        case .alert: return "Alert"
        case .banner: return "Banner"
        case .none: return "None"
        }
    }
}



