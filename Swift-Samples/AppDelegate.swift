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

    var window: UIWindow?
    var tabBarViewController: UITabBarController?
    var navViewController1: UINavigationController?
    var navViewController2: UINavigationController?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject:AnyObject]?) -> Bool {
        // Override point for customization after application launch.

        window = UIWindow(frame: UIScreen.mainScreen().bounds)

        //--- 第一个标签页 ---
        let tableViewController1 = UITableViewController(style: UITableViewStyle.Plain)
        tableViewController1.tableView.dataSource = self
        tableViewController1.tableView.delegate = self
        tableViewController1.title = "Swift学习示例"

        navViewController1 = UINavigationController(rootViewController: tableViewController1)
        navViewController1?.delegate = self;
        navViewController1?.tabBarItem.title = "Swift学习"
        navViewController1?.tabBarItem.image = UIImage(named: "aa")


        //--- 第二个标签页 ---
        let tableViewController2 = UITableViewController(style: UITableViewStyle.Plain)
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
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


    //UITableViewDataSource 实现
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        switch tabBarViewController!.selectedIndex {
            //Swift学习
        case 0:
            count = 2
            
            //先锋Demo
        case 1:
            count = 2
        default:break
        }
        return count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
            cell!.accessoryType = .DisclosureIndicator
        }

        
        switch tabBarViewController!.selectedIndex {
            //Swift学习
        case 0:
            switch indexPath.row {
            case 0:
                cell!.textLabel!.text = "Enum,Struct,Property"
            case 1:
                cell!.textLabel!.text = "类型转换"
            default: break
            }
            
            //先锋Demo
        case 1:
            switch indexPath.row {
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

    //UITableViewDelegate 实现
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        
        switch tabBarViewController!.selectedIndex {
            //Swift学习
        case 0:
            switch indexPath.row {
            case 0:
                let storeboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storeboard.instantiateInitialViewController() as! ViewController
                navViewController1!.pushViewController(viewController, animated: true)
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
            case 1:
                let typeCastVC = TypeCastViewController()
                navViewController1!.pushViewController(typeCastVC, animated: true)
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
            default: break
            }
            
            //先锋Demo
        case 1:
            switch indexPath.row {
            case 0:
                let mutiScrollVC = MutiScrollViewController()
                navViewController2?.pushViewController(mutiScrollVC, animated: true)
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
            case 1:
                let testVC = TestViewController()
                navViewController2?.pushViewController(testVC, animated: true)
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
            default: break
            }
            
        default:break
        }
        
    }
    
    
    //UITabBarControllerDelegate 实现
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        let transition = CATransition()
        transition.type = kCATransitionFade
        tabBarController.view.layer.addAnimation(transition, forKey: nil)
    }


}

