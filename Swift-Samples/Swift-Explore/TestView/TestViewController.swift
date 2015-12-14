//
//  TestViewController.swift
//  Swift-Samples
//
//  Created by luowei on 15/12/14.
//  Copyright © 2015年 wodedata. All rights reserved.
//

import UIKit
import FLAnimatedImage
import MyThirdLibs

class TestViewController: UIViewController {

    var gifImageView :FLAnimatedImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //添加一个子视图
        let testView = TestView(frame: self.view.frame);
        self.view.addSubview(testView);
        
        //添加一张Gif图
        let path = NSBundle.mainBundle().pathForResource("testGif", ofType: "gif")
        //        let url = NSURL(fileURLWithPath: path!)
        let gifData = NSData(contentsOfFile: path!)
        let image = FLAnimatedImage(animatedGIFData: gifData)
        
        gifImageView = FLAnimatedImageView()
        gifImageView!.center = CGPointMake(self.view.center.x,self.view.center.y + 30);
        gifImageView!.bounds = CGRectMake(0, 0, 100, 100)
        gifImageView!.animatedImage = image
        
        self.view.addSubview(gifImageView!)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gifImageView!.center = CGPointMake(self.view.center.x,self.view.center.y + 30);
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.hidden = true
        self.tabBarController!.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController!.navigationBar.hidden = false
        self.tabBarController!.tabBar.hidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
