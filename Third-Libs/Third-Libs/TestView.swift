//
//  TestView.swift
//  Third-Libs
//
//  Created by luowei on 15/12/10.
//  Copyright © 2015年 2345. All rights reserved.
//

import UIKit

open class TestView: UIView {
    var textText : UILabel

    override public init (frame : CGRect) {
        
        textText = UILabel(frame: CGRect(x: frame.size.width/2-100,y: frame.size.height/2-100,width: 200,height: 60))
        textText.text = "这是测试视图"
        textText.textAlignment = .center
        textText.font = UIFont.systemFont(ofSize: 24)
        
        super.init(frame : frame)
        
        self.backgroundColor = UIColor.orange
        
        setupViews()
    }
    
    convenience init () {
        self.init(frame:CGRect.zero)
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    override open func layoutSubviews(){
        let frame = (self.superview?.frame)!
        self.frame = frame;
        textText.frame = CGRect(x: frame.size.width/2-100,y: frame.size.height/2-100,width: 200,height: 60)
    }
    
    func setupViews (){
        //添加子视图
        self.addSubview(textText)
    }

    open func aaa(){
        print("Hello World,This is TestView")
    }



}
