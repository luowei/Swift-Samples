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
        let path = Bundle.main.path(forResource: "testGif", ofType: "gif")
        //        let url = NSURL(fileURLWithPath: path!)
        let gifData = try? Data(contentsOf: URL(fileURLWithPath: path!))
        let image = FLAnimatedImage(animatedGIFData: gifData)
        
        gifImageView = FLAnimatedImageView()
        gifImageView!.center = CGPoint(x: self.view.center.x,y: self.view.center.y + 30);
        gifImageView!.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        gifImageView!.animatedImage = image
        
        self.view.addSubview(gifImageView!)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gifImageView!.center = CGPoint(x: self.view.center.x,y: self.view.center.y + 30);
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.isHidden = true
        self.tabBarController!.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController!.navigationBar.isHidden = false
        self.tabBarController!.tabBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
