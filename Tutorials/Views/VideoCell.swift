//
//  VideoCell.swift
//  Tutorials
//
//  Created by Marcus on 7/15/20.
//  Copyright © 2020 Marcus. All rights reserved.
//

import UIKit

class VideoCell: UICollectionViewCell {
	// MARK: reuseIdentifier
	static let reuseIdentifier: String = String(describing: self)
	
	
	// MARK: subview properties
	private let displayLabel = UILabel(frame: .zero)
	
	
	// MARK: public setters
	var displayText: String? {
		didSet {
			displayLabel.text = displayText
		}
	}
	
	
	// MARK: inits
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		configureSubviews()
		layoutVideoSubviews()
	}
	required init?(coder: NSCoder) {
		fatalError("Crash in VideoCell")
	}
	
	
	// MARK: private helper methods
	private func configureSubviews() {
		displayLabel.translatesAutoresizingMaskIntoConstraints = false
		displayLabel.font = .preferredFont(forTextStyle: .body)
		displayLabel.textColor = .white
		displayLabel.numberOfLines = 1
		contentView.addSubview(displayLabel)
	}
	private func layoutVideoSubviews() {
		displayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0).isActive = true
		displayLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0).isActive = true
		displayLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
	}
}
