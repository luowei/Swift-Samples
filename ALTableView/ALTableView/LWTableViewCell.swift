//
//  TestTableViewCell.swift
//  testAutoLayoutCell
//
//  Created by Apple on 6/19/15.
//  Copyright (c) 2015 William Hu. All rights reserved.
//

import UIKit

class LWTableViewCell: UITableViewCell {

    @IBOutlet weak var wrapView: ACEPartRoundedCornerView!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var bottomLine: UIView!
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        for view in wrapView.subviews {
//            guard let label = view as? UILabel where label.numberOfLines == 0 else { continue }
//            label.preferredMaxLayoutWidth = CGRectGetWidth(label.frame)
//        }
//
//    }

    func fill(type: ACETableViewCellPositionType, text: String) {
        switch type {
        case let t where t.contains(.MixTopBottomInSection):
            self.wrapView.roundedPart = [.BottomLeft, .BottomRight, .TopLeft, .TopRight]
        case let t where t.contains(.TopInSection):
            self.wrapView.roundedPart = [.TopLeft, .TopRight]
        case let t where t.contains(.BottomInSection):
            self.wrapView.roundedPart = [.BottomLeft, .BottomRight]
        default:
            self.wrapView.roundedPart = .None
        }
        self.content.text = text
    }

    @IBAction func callAction(sender: UIButton) {
        guard let text = self.phoneLabel.text as String?,
        let phone = text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) as String? else{
            return
        }
        UIApplication.sharedApplication().openURL(NSURL(string: "telprompt://" + phone)!);
    }
}
