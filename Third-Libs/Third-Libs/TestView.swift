//
//  TestView.swift
//  Lottery-Libs
//
//  Created by luowei on 15/12/10.
//  Copyright © 2015年 2345. All rights reserved.
//

import UIKit

public class TestView: UIView {
    var textText : UILabel

    override public init (frame : CGRect) {
        
        textText = UILabel(frame: CGRectMake(frame.size.width/2-100,frame.size.height/2-100,200,60))
        textText.text = "这是测试视图"
        textText.textAlignment = .Center
        textText.font = UIFont.systemFontOfSize(24)
        
        super.init(frame : frame)
        
        self.backgroundColor = UIColor.orangeColor()
        
        setupViews()
    }
    
    convenience init () {
        self.init(frame:CGRect.zero)
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    override public func layoutSubviews(){
        let frame = (self.superview?.frame)!
        self.frame = frame;
        textText.frame = CGRectMake(frame.size.width/2-100,frame.size.height/2-100,200,60)
    }
    
    func setupViews (){
        //添加子视图
        self.addSubview(textText)
    }

    public func aaa(){
        print("Hello World,This is TestView")
    }



}
