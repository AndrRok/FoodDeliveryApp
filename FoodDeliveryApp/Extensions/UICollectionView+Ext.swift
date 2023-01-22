//
//  UITableView+Ext.swift
//  FoodDeliveryApp
//
//  Created by ARMBP on 1/21/23.
//

import UIKit

extension UICollectionView {

    func isCellAtIndexPathFullyVisible(_ indexPath: IndexPath) -> Bool {

        guard let layoutAttribute = layoutAttributesForItem(at: indexPath) else {
            return false
        }

        let cellFrame = layoutAttribute.frame
        return self.bounds.contains(cellFrame)
    }

    func indexPathsForFullyVisibleItems() -> [IndexPath] {

        let visibleIndexPaths = indexPathsForVisibleItems

        return visibleIndexPaths.filter { indexPath in
            return isCellAtIndexPathFullyVisible(indexPath)
        }
    }
}
