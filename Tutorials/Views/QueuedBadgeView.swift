//
//  QueuedBadgeView.swift
//  Tutorials
//
//  Created by Marcus on 7/19/20.
//  Copyright © 2020 Marcus. All rights reserved.
//

import UIKit

class QueuedBadgeView: UICollectionReusableView {
	// reuseIdentifier
	static let reuseIdentifier: String = String(describing: self)
	
	// stored properties
	private let bookmarkImageView = UIImageView(frame: .zero)
	
	// setters
	var isQueued: Bool? {
		didSet {
			if let queued = isQueued {
				// only show when Tutorial isQueued
				bookmarkImageView.isHidden = !queued
			}
		}
	}
	
	// inits
	override init(frame: CGRect) {
		super.init(frame: frame)

		configureSubviews()
	}
	required init?(coder: NSCoder) {
		fatalError("Crash in QueuedBadgeView")
	}
	
	private func configureSubviews() {
		bookmarkImageView.translatesAutoresizingMaskIntoConstraints = false
		bookmarkImageView.image = UIImage(systemName: "bookmark.fill")
		bookmarkImageView.isHidden = true // only show when Tutorial isQueued
		addSubview(bookmarkImageView)
		
		bookmarkImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		bookmarkImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		bookmarkImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		bookmarkImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
	}
}