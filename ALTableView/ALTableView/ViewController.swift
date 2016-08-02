//
//  ViewController.swift
//  GSTableView
//
//  Created by Apple on 6/19/15.
//  Copyright (c) 2015 William Hu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var offScreenCells: NSMutableDictionary! = NSMutableDictionary()
    var datas = ["nihaosf sad fsad fasd fas fsaf sdf sad fas","Unlike Objective-C, the elements of an array must be of the same type. In the examples above, implicit typing can deduce that the static array is a string array and the dynamic is an integer array. We can declare an array of a given type by placing the element’s type in square brackets. An integer dynamic array would look like this:"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //iOS7兼容处理
        if NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1 {
            self.tableView.estimatedRowHeight = 80
            self.tableView.rowHeight = UITableViewAutomaticDimension
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("comments_cell") as! LWTableViewCell
        
        if (indexPath.row == 0) {
            cell.fill(.TopInSection, text: self.datas[indexPath.row])
        }
        if (indexPath.row == self.datas.count - 1) {
            cell.fill(.BottomInSection, text: self.datas[indexPath.row])
            cell.bottomLine.hidden = true
        }else{
            cell.bottomLine.hidden = false
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1 {
            return UITableViewAutomaticDimension
        }

         let cell = tableView.dequeueReusableCellWithIdentifier("comments_cell") as! LWTableViewCell
          
        cell.content.preferredMaxLayoutWidth = CGRectGetWidth(tableView.bounds)
        cell.content.text = datas[indexPath.row]

        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        let height = cell.contentView.systemLayoutSizeFittingSize(UILayoutFittingExpandedSize).height + 1.0
        return height
    }

}
