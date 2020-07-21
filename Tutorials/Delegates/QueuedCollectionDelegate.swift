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
		if let almostSelectedItem = collectionView.cellForItem(at: indexPath)?.isSelected,
			 almostSelectedItem == false {
			collectionView.deselectItem(at: indexPath, animated: true)
		} else {
			collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
			return true
		}
		return false
	}
}
