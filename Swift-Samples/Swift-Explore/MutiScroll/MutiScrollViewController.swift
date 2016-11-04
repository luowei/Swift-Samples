//
// Created by luowei on 15/11/16.
// Copyright (c) 2015 wodedata. All rights reserved.
//

import UIKit

class MutiScrollViewController : UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
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


}
