//
//  ACEPartRoundedCorner.swift
//  ACERepair
//
//  Created by Salo on 16/4/15.
//  Copyright © 2016年 2345.com. All rights reserved.
//

import UIKit

struct ACETableViewCellPositionType: OptionSetType {
    var rawValue = 0

    static var Mid              = ACETableViewCellPositionType(rawValue: 1 << 0)
    static var TopInSection     = ACETableViewCellPositionType(rawValue: 1 << 1)
    static var BottomInSection  = ACETableViewCellPositionType(rawValue: 1 << 2)

    static var TopInTableView       = ACETableViewCellPositionType(rawValue: 1 << 10).union(.TopInSection)
    static var BottomInTableView    = ACETableViewCellPositionType(rawValue: 1 << 11).union(.BottomInSection)

    static var MixTopBottomInSection    = TopInSection.union(.BottomInSection)
    static var MixTopBottomInTableView  = TopInTableView.union(.BottomInTableView)
}

struct ACERoundedCornerPart: OptionSetType {
    var rawValue = 0

    static var TopLeft      = ACERoundedCornerPart(rawValue: 1 << 1)
    static var TopRight     = ACERoundedCornerPart(rawValue: 1 << 2)
    static var BottomLeft   = ACERoundedCornerPart(rawValue: 1 << 3)
    static var BottomRight  = ACERoundedCornerPart(rawValue: 1 << 4)
    static var None         = ACERoundedCornerPart(rawValue: 1 << 0)
}

class ACEPartRoundedCornerView: UIView {

    private var _roundedBackgroundColor: UIColor?
    override var backgroundColor: UIColor? {
        set { _roundedBackgroundColor = newValue }
        get { return _roundedBackgroundColor }
    }

    var cornerRadius: CGFloat = 0
    var roundedPart: ACERoundedCornerPart = .None {
        didSet {
            self.setNeedsDisplay()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        super.backgroundColor = UIColor.clearColor()
    }

    override func drawRect(rect: CGRect) {

        let ctx = UIGraphicsGetCurrentContext()
        let cornerRadius = self.cornerRadius
        let width = self.frame.size.width
        let height = self.frame.size.height
        let fillColor = self._roundedBackgroundColor?.CGColor ?? UIColor.whiteColor().CGColor
        let fullRect = self.bounds

        if self.roundedPart == .None {
            CGContextAddRect(ctx, fullRect)
            CGContextSetFillColorWithColor(ctx, fillColor)
            CGContextFillPath(ctx)
            return
        }

        CGContextClearRect(ctx, fullRect)

        if self.roundedPart.contains(.TopLeft) {
            CGContextMoveToPoint(ctx, 0, cornerRadius)
            CGContextAddArcToPoint(ctx,
                    0,
                    0,
                    cornerRadius,
                    0,
                    cornerRadius)
        } else {
            CGContextMoveToPoint(ctx, 0, 0)
        }

        if self.roundedPart.contains(.TopRight) {
            CGContextAddArcToPoint(ctx,
                    width,
                    0,
                    width,
                    cornerRadius,
                    cornerRadius)
        } else {
            CGContextAddLineToPoint(ctx, width, 0)
        }

        if self.roundedPart.contains(.BottomRight) {
            CGContextAddArcToPoint(ctx,
                    width,
                    height,
                    width - cornerRadius,
                    height,
                    cornerRadius)
        } else {
            CGContextAddLineToPoint(ctx, width, height)
        }

        if self.roundedPart.contains(.BottomLeft) {
            CGContextAddArcToPoint(ctx,
                    0,
                    height,
                    0,
                    height - cornerRadius,
                    cornerRadius)
        } else {
            CGContextAddLineToPoint(ctx, 0, height)
        }

        CGContextClosePath(ctx)

        CGContextSetFillColorWithColor(ctx, fillColor)
        CGContextFillPath(ctx)

    }

}
