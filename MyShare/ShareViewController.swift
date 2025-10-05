//
//  ShareViewController.swift
//  MyShare
//
//  Created by luowei on 2016/11/4.
//  Copyright © 2016年 wodedata. All rights reserved.
//

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {
    var img:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let imageItem = self.extensionContext?.inputItems.first as? NSExtensionItem,
            let imageItemProvider = imageItem.attachments?.first as? NSItemProvider else{
                return
        }
        if imageItemProvider.hasItemConformingToTypeIdentifier("public.url") {
            imageItemProvider.loadItem(forTypeIdentifier: "public.url", options: nil){[unowned self](image,error) in
                self.img = image as? UIImage
            }
            
        }
    }

    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        guard let imageItem = self.extensionContext?.inputItems.first as? NSExtensionItem,
        let imageItemProvider = imageItem.attachments?.first as? NSItemProvider else{
            return false
        }
        if(imageItemProvider.hasItemConformingToTypeIdentifier("public.url") && (self.contentText != nil)){
            return true
        }
        
        return true
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        
        guard let imageItem = self.extensionContext?.inputItems.first as? NSExtensionItem else{
            return
        }
        let alert = UIAlertController(title: "aaa", message: "bbbbbbb", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        
        guard let outputItem = imageItem.copy() as? NSExtensionItem else{
            return
        }
        outputItem.attributedContentText = NSAttributedString(string: self.contentText, attributes: nil)
        
        self.extensionContext!.completeRequest(returningItems: [outputItem], completionHandler: nil)
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        
        guard let oneItem = SLComposeSheetConfigurationItem() as SLComposeSheetConfigurationItem? else{
            return []
        }
        oneItem.title = "MyShare测试"
        oneItem.valuePending = false
        oneItem.tapHandler = {
            guard let sharedVC = UIStoryboard(name: "MyShare", bundle: nil) as UIStoryboard? else{
                return
            }
            let vc = sharedVC.instantiateViewController(withIdentifier: "SharedViewController")
            self.pushConfigurationViewController(vc)
        }
        
        
        return [oneItem]
    }

}
