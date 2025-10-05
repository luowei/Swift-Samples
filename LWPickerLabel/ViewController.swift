//
//  ViewController.swift
//  LWPickerLabel
//
//  Created by luowei on 16/8/5.
//  Copyright © 2016年 wodedata. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var textLabel: LWAddressLabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //let text = NSMutableAttributedString(string: "aaabbbb")
        var main_string = "Hello World aaaaaaaaa aaaaaaaaa aaaaaaaaa aaaaaaaaa aaaaaaaaa aaaaaaaaa aaaaaaaaa bbbb aaaaaaaaa aaaaaaaaa"
        var string_to_color = "bbbb"
        var range = (main_string as NSString).rangeOfString(string_to_color)
        
        var attributedString = NSMutableAttributedString(string:main_string)
//        attributedString.addAttribute(
//            NSForegroundColorAttributeName, value: UIColor.redColor() , range: NSRange(location: 0,length: 5))
        attributedString.addAttributes([
            NSForegroundColorAttributeName : UIColor.redColor(),
            NSFontAttributeName : UIFont.systemFontOfSize(21)
            ], range: NSRange(location: 0,length: 5))
        attributedString.addAttributes([
            NSForegroundColorAttributeName : UIColor.redColor(),
            NSFontAttributeName : UIFont.systemFontOfSize(30)
            ], range: range)
        
        textLabel.attributedText = attributedString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

