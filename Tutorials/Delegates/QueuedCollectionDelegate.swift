//
//  QueuedCollectionDelegate.swift
//  Tutorials
//
//  Created by Marcus on 7/20/20.
//  Copyright © 2020 Marcus. All rights reserved.
//

import UIKit

class QueuedCollectionDelegate: NSObject, UICollectionViewDelegate {
	// manually handle the selection/delesection of collectionView cells
	func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
		if collectionView.cellForItem(at: indexPath)?.isSelected ?? false {
			collectionView.deselectItem(at: indexPath, animated: true)
			return false
		}
		return true
	}
}
