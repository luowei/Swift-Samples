//
//  Extensions.swift
//  LWPickerLabel
//
//  Created by luowei on 16/8/8.
//  Copyright © 2016年 wodedata. All rights reserved.
//

import UIKit

extension UIView {
    class func loadFromNibNamed(nibNamed: String, bundle : NSBundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiateWithOwner(nil, options: nil)[0] as? UIView
    }
}

private var pTouchAreaEdgeInsets: UIEdgeInsets = UIEdgeInsetsZero

extension UIButton {

    //负值加大点击区域，正值缩小点击区域
    var touchAreaEdgeInsets: UIEdgeInsets {
        get {
            if let value = objc_getAssociatedObject(self, &pTouchAreaEdgeInsets) as? NSValue {
                var edgeInsets = UIEdgeInsetsZero
                value.getValue(&edgeInsets)
                return edgeInsets
            }
            else {
                return UIEdgeInsetsZero
            }
        }
        set(newValue) {
            var newValueCopy = newValue
            let objCType = NSValue(UIEdgeInsets: UIEdgeInsetsZero).objCType
            let value = NSValue(&newValueCopy, withObjCType: objCType)
            objc_setAssociatedObject(self, &pTouchAreaEdgeInsets, value, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    public override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        if UIEdgeInsetsEqualToEdgeInsets(self.touchAreaEdgeInsets, UIEdgeInsetsZero) || !self.enabled || self.hidden {
            return super.pointInside(point, withEvent: event)
        }
        
        let relativeFrame = self.bounds
        let hitFrame = UIEdgeInsetsInsetRect(relativeFrame, self.touchAreaEdgeInsets)
        
        return CGRectContainsPoint(hitFrame, point)
    }
}