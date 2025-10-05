//
//  AppSearchViewController.swift
//  Swift-Samples
//
//  Created by luowei on 2016/11/5.
//  Copyright © 2016年 wodedata. All rights reserved.
//

import UIKit
import CoreSpotlight
import MobileCoreServices

class AppSearchViewController: UIViewController {
    
    public var attributeSet: CSSearchableItemAttributeSet {
        
        //创建 SearchableItemAttributeSet
        let attributeSet = CSSearchableItemAttributeSet(
            itemContentType: kUTTypeContent as String)
        attributeSet.title = "App Search 测试"
        attributeSet.contentDescription = "App Search 测试示例应用，这是attributeSet.contentDescription"
        attributeSet.thumbnailData = UIImageJPEGRepresentation(UIImage(named:"AppSearch-Spotlight")!, 0.75)
        attributeSet.supportsPhoneCall = true
        
        attributeSet.phoneNumbers = ["15821422479"]
        attributeSet.emailAddresses = ["luowei@wodedata.com"]
        attributeSet.keywords = ["维唯为为","wodedata.com"]
        attributeSet.relatedUniqueIdentifier = "luowei_appsearch"
        
        //创建 SearchableItem
        let item = CSSearchableItem(uniqueIdentifier: "MyAppSearch", domainIdentifier: "wodedata.com", attributeSet: attributeSet)
        
        //更新搜索项
        CSSearchableIndex.default().indexSearchableItems([item]){(error) in
            print("error:\((error as? NSError)?.description)")
        }
        
        return attributeSet
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //设置userActivity
        userActivity = NSUserActivity(activityType: "AppSearch")
        userActivity?.title = "luowei"
        userActivity?.userInfo = ["luowei":"这是我的第一个App搜索支持应用。wodedata.com","wodedata":"wodedata.com"]
        userActivity?.requiredUserInfoKeys = NSSet(array: ["luowei","wodedata"]) as! Set<String>
        userActivity?.isEligibleForSearch = true
        userActivity?.isEligibleForPublicIndexing = true
        
        userActivity?.keywords = ["维唯为为","wodedata.com"]
        userActivity?.contentAttributeSet = attributeSet
        userActivity?.becomeCurrent()
    }
    
    // 更新NSUserActivity关联的信息
    override func updateUserActivityState(_ activity: NSUserActivity) {
        activity.addUserInfoEntries(from: activity.userInfo ?? ["luowei":"这是我的第一个App搜索支持应用。wodedata.com"])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
