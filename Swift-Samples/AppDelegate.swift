//
//  AppDelegate.swift
//  Swift-Samples
//
//  Created by luowei on 15/11/3.
//  Copyright © 2015年 wodedata. All rights reserved.
//

import UIKit




@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UITabBarControllerDelegate,UINavigationControllerDelegate,
        UITableViewDataSource, UITableViewDelegate {

    var notificationFromLaunchOptions = false
    
    var window: UIWindow?
    var tabBarViewController: UITabBarController?
    var navViewController1: UINavigationController?
    var navViewController2: UINavigationController?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        window = UIWindow(frame: UIScreen.main.bounds)

        //--- 第一个标签页 ---
        let tableViewController1 = UITableViewController(style: UITableViewStyle.plain)
        tableViewController1.tableView.dataSource = self
        tableViewController1.tableView.delegate = self
        tableViewController1.title = "Swift示例"

        navViewController1 = UINavigationController(rootViewController: tableViewController1)
        navViewController1?.delegate = self;
        navViewController1?.tabBarItem.title = "Swift小测试"
        navViewController1?.tabBarItem.image = UIImage(named: "aa")


        //--- 第二个标签页 ---
        let tableViewController2 = UITableViewController(style: UITableViewStyle.plain)
        tableViewController2.tableView.dataSource = self
        tableViewController2.tableView.delegate = self
        tableViewController2.title = "先锋Demo示例"

        navViewController2 = UINavigationController(rootViewController: tableViewController2)
        navViewController2?.delegate = self;
        navViewController2?.tabBarItem.title = "先锋Demo"
        navViewController2?.tabBarItem.image = UIImage(named: "bb")

        //下方tab条视图控制器
        tabBarViewController = UITabBarController()
        tabBarViewController?.viewControllers = [navViewController1!,navViewController2!]

        window?.rootViewController = tabBarViewController
        window?.makeKeyAndVisible()
        
        //----- 数据环境初始化
        //信鸽初化推送
        //XGPush.startApp(XGPushConf.appId,appKey:XGPushConf.appKey)
        //清除角标
        application.applicationIconBadgeNumber = 0
        //推送反馈(app不在前台运行时，点击推送激活时)
        XGPush.handleLaunching(launchOptions)
        
        //当App不在运行状态时,处理推送消息
        if let options = launchOptions, let notification = options[UIApplicationLaunchOptionsKey.remoteNotification] as? [NSObject:AnyObject] {
            let time: DispatchTime = DispatchTime.now() + Double(Int64(0.25 * Double(NSEC_PER_SEC)))
            DispatchQueue.main.asyncAfter(deadline: time){
                self.notificationFromLaunchOptions = true
                self.application(application, didReceiveRemoteNotification: notification)
            }
        }
        
        
        return true
    }
    
    // 远程推送注册成功，获取deviceToken
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        //注册设备
        guard (Optional.some(deviceToken) as NSData?) != nil else{
            return
        }
        //ACEPushManager.pushManager.registerDevice(token)
    }

    // 远程推送注册失败
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        if (error as NSError).code == 3010 {
            print("Push notifications are not supported in the iOS Simulator.")
        } else {
            print("application:didFailToRegisterForRemoteNotificationsWithError: \(error) ")
        }
    }
    
    // 收到远程推送通知
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print("收到远程推送")
        //清除角标
        application.applicationIconBadgeNumber = 0
        
        //处理推送消息
        XGPush.handleReceiveNotification(userInfo);
        
    }
    
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    //app进入后台
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    //app从后台被激活
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    //app将终止
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        if userActivity.activityType == "AppSearch" {
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AppSearchViewController") as! AppSearchViewController
            navViewController1?.pushViewController(viewController, animated: true)
            
//            navViewController1?.restoreUserActivityState(userActivity)
        }
        
        return false
    }


    //MARK: - UITableViewDataSource 实现
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        switch tabBarViewController!.selectedIndex {
            //Swift小测试
        case 0:
            count = 3
            
            //先锋Demo
        case 1:
            count = 2
        default:break
        }
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
            cell!.accessoryType = .disclosureIndicator
        }

        
        switch tabBarViewController!.selectedIndex {
            //Swift小测试
        case 0:
            switch (indexPath as NSIndexPath).row {
            case 0:
                cell!.textLabel!.text = "Enum,Struct,Property"
            case 1:
                cell!.textLabel!.text = "类型转换"
            case 2:
                cell!.textLabel!.text = "App Search"
            default: break
            }
            
            //先锋Demo
        case 1:
            switch (indexPath as NSIndexPath).row {
            case 0:
                cell!.textLabel!.text = "Multi Scroll"
            case 1:
                cell!.textLabel!.text = "测试视图"
            default: break
            }
            
        default:break
        }

        return cell!
    }

    //MARK: - UITableViewDelegate 实现
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        switch tabBarViewController!.selectedIndex {
            //Swift学习
        case 0:
            switch (indexPath as NSIndexPath).row {
            case 0:
                let storeboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storeboard.instantiateInitialViewController() as! ViewController
                navViewController1!.pushViewController(viewController, animated: true)
                tableView.deselectRow(at: indexPath, animated: true)
            case 1:
                let typeCastVC = TypeCastViewController()
                navViewController1!.pushViewController(typeCastVC, animated: true)
                tableView.deselectRow(at: indexPath, animated: true)
            case 2:
                let storeboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storeboard.instantiateViewController(withIdentifier: "AppSearchViewController") as! AppSearchViewController
                navViewController1!.pushViewController(viewController, animated: true)
                tableView.deselectRow(at: indexPath, animated: true)
            default: break
            }
            
            //先锋Demo
        case 1:
            switch (indexPath as NSIndexPath).row {
            case 0:
                let mutiScrollVC = MutiScrollViewController()
                navViewController2?.pushViewController(mutiScrollVC, animated: true)
                tableView.deselectRow(at: indexPath, animated: true)
            case 1:
                let testVC = TestViewController()
                navViewController2?.pushViewController(testVC, animated: true)
                tableView.deselectRow(at: indexPath, animated: true)
            default: break
            }
            
        default:break
        }
        
    }
    
    
    //MARK: - UITabBarControllerDelegate 实现
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let transition = CATransition()
        transition.type = kCATransitionFade
        tabBarController.view.layer.add(transition, forKey: nil)
    }


}

