//
//  QueuedCollectionDelegate.swift
//  Tutorials
//
//  Created by Marcus on 7/20/20.
//  Copyright © 2020 Marcus. All rights reserved.
//

import UIKit

protocol QueuedSelectionDelegate: AnyObject {
	func didSelectItem(atIndexPath indexPath: IndexPath)
}

class QueuedCollectionDelegate: NSObject, UICollectionViewDelegate {
	var isEditing: Bool = false
	weak var delegate: QueuedSelectionDelegate?
	
	// manually handle the selection/delesection of collectionView cells
	func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
		print("From the selection delegate: \(isEditing)")
		if !isEditing { return false } // ignore logic if not in editing mode
		if collectionView.cellForItem(at: indexPath)?.isSelected ?? false {
			collectionView.deselectItem(at: indexPath, animated: true)
			return false
		}
		return true
	}
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		delegate?.didSelectItem(atIndexPath: indexPath)
	}
}
