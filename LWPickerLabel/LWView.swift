//
//  LWView.swift
//  LWPickerLabel
//
//  Created by luowei on 16/8/8.
//  Copyright © 2016年 wodedata. All rights reserved.
//

import UIKit


@IBDesignable
class LWView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor() {
        didSet {
            layer.borderColor = borderColor.CGColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
}

class LWTableView : UITableView {

    
    //set the tableHeaderView so that the required height can be determined, update the header's frame and set it again
    func setAndLayoutTableHeaderView(header: UIView) {
        self.tableHeaderView = header
        
        for view in header.subviews {
            guard let label = view as? UILabel where label.numberOfLines == 0 else { continue }
            label.preferredMaxLayoutWidth = CGRectGetWidth(label.frame)
        }
        
        header.setNeedsLayout()
        header.layoutIfNeeded()
        var frame = header.frame
        
        //        let height = header.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
        //        //let height = header.systemLayoutSizeFittingSize(UILayoutFittingExpandedSize).height
        //        frame.size.height = height
        
        
        let size = header.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        //let size = header.systemLayoutSizeFittingSize(UILayoutFittingExpandedSize, withHorizontalFittingPriority: UILayoutPriorityDefaultHigh, verticalFittingPriority: UILayoutPriorityFittingSizeLevel)
        frame.size = size
        
        header.frame = frame
        self.tableHeaderView = header
    }
    
    func sizeHeaderToFit(preferredWidth: CGFloat) {
        guard let headerView = self.tableHeaderView else {
            return
        }
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        let layout = NSLayoutConstraint(
            item: headerView,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: nil,
            attribute:
            .NotAnAttribute,
            multiplier: 1,
            constant: preferredWidth)
        
        headerView.addConstraint(layout)
        
        let height = headerView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
        headerView.frame = CGRectMake(0, 0, preferredWidth, height)
        
        headerView.removeConstraint(layout)
        headerView.translatesAutoresizingMaskIntoConstraints = true
        
        self.tableHeaderView = headerView
    }
    
}
