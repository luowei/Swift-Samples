//
// Created by luowei on 15/11/16.
// Copyright (c) 2015 wodedata. All rights reserved.
//

import UIKit

class MutiScrollViewController : UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGrayColor()
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


}
