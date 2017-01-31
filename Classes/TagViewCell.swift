//
//  TagViewCell.swift
//  AKTagControl
//
//  Created by prema janoti on 1/6/17.
//  Copyright © 2017 prema janoti. All rights reserved.
//

public protocol TagViewCellDelegate {
     func didSelectCross(_ forCell: TagViewCell)
}

import UIKit

open class Tag {

    var name: String?
    var selected = false
}

 open class TagViewCell: UICollectionViewCell {
    @IBOutlet weak var tagName: UILabel!
    @IBOutlet weak var tagNameMaxWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnCross: UIButton!
    var delegate: TagViewCellDelegate?
    var indexPath: IndexPath?

    override open func awakeFromNib() {
        self.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        self.tagName.textColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        self.layer.cornerRadius = 10

        self.tagNameMaxWidthConstraint.constant = UIScreen.main.bounds.width - 8 * 2 - 8 * 2
    }

    override open func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {

        for i in (0 ..< subviews.count-2).reversed() {
            let newPoint = subviews[i].convert(point, from: self)
            let view = subviews[i].hitTest(newPoint, with: event)
            if view != nil {
                return view
            }
        }

        return super.hitTest(point, with: event)
    }

    @IBAction func btnCrossTapped(_ sender: Any) {

        self.delegate?.didSelectCross(self)
    }

}
