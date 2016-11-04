//
//  RequestHandler.swift
//  MyShareLinks
//
//  Created by luowei on 2016/11/4.
//  Copyright © 2016年 wodedata. All rights reserved.
//

import Foundation

class RequestHandler: NSObject, NSExtensionRequestHandling {

    func beginRequest(with context: NSExtensionContext) {
        let extensionItem = NSExtensionItem()
        
        // The keys of the user info dictionary match what data Safari is expecting for each Shared Links item.
        // For the date, use the publish date of the content being linked
        extensionItem.userInfo = [ AnyHashable("uniqueIdentifier"): "uniqueIdentifierForSampleItem", AnyHashable("urlString"): "http://wodedata.com", AnyHashable("date"): NSDate() ]
        
        extensionItem.attributedTitle = NSAttributedString(string: "wodedata展示小站")
        extensionItem.attributedContentText = NSAttributedString(string: "简致现代风，自由技术人")
        
        // You can supply a custom image to be used with your link as well. Use the NSExtensionItem's attachments property.
        extensionItem.attachments = [ NSItemProvider(contentsOf: Bundle.main.url(forResource: "wodedata128x128", withExtension: "png"))! ]
        

        context.completeRequest(returningItems: [extensionItem], completionHandler: nil)
    }

}
