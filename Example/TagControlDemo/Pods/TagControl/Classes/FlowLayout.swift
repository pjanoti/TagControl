//
//  FlowLayout.swift
//  TagFlowLayout
//
//  Created by prema janoti on 1/6/17.
//  Copyright © 2017 prema janoti. All rights reserved.
//

import UIKit

class FlowLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributesForElementsInRect = super.layoutAttributesForElements(in: rect)
        var newAttributesForElementsInRect = [UICollectionViewLayoutAttributes]()

        var leftMargin: CGFloat = 0.0

        for attributes in attributesForElementsInRect! {
            if attributes.frame.origin.x == self.sectionInset.left {
                leftMargin = self.sectionInset.left
            } else {
                var newLeftAlignedFrame = attributes.frame
                newLeftAlignedFrame.origin.x = leftMargin
                attributes.frame = newLeftAlignedFrame
            }
            leftMargin += attributes.frame.size.width + 8
            newAttributesForElementsInRect.append(attributes)
        }

        return newAttributesForElementsInRect
    }
}
