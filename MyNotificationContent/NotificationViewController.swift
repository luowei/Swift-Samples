//
//  NotificationViewController.swift
//  MyNotificationContent
//
//  Created by luowei on 2016/11/4.
//  Copyright © 2016年 wodedata. All rights reserved.
//
//参见Demo:https://github.com/onevcat/UserNotificationDemo

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        self.label?.text = notification.request.content.body
    }

}
