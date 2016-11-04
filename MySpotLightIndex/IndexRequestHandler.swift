//
//  IndexRequestHandler.swift
//  MySpotLightIndex
//
//  Created by luowei on 2016/11/5.
//  Copyright © 2016年 wodedata. All rights reserved.
//

import CoreSpotlight
import MobileCoreServices
import UIKit

class IndexRequestHandler: CSIndexExtensionRequestHandler {

    override func searchableIndex(_ searchableIndex: CSSearchableIndex, reindexAllSearchableItemsWithAcknowledgementHandler acknowledgementHandler: @escaping () -> Void) {
        // Reindex all data with the provided index
        
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
        
        //添加/更新搜索项
        CSSearchableIndex.default().indexSearchableItems([item]){(error) in
            print("error:\((error as? NSError)?.description)")
        }
        
        acknowledgementHandler()
    }
    
    override func searchableIndex(_ searchableIndex: CSSearchableIndex, reindexSearchableItemsWithIdentifiers identifiers: [String], acknowledgementHandler: @escaping () -> Void) {
        // Reindex any items with the given identifiers and the provided index
        
        if !identifiers.filter({$0 == "MyAppSearch"}).isEmpty {
            print("================ MyAppSearch")
        }
        
        acknowledgementHandler()
    }

}
