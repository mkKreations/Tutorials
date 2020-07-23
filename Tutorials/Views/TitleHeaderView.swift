//
//  TitleHeaderView.swift
//  Tutorials
//
//  Created by Marcus on 7/14/20.
//  Copyright © 2020 Marcus. All rights reserved.
//

import UIKit

class TitleHeaderView: UICollectionReusableView {
	// reuseIdentifier
	static let reuseIdentifier: String = String(describing: self)
	
	// private view properties
	private let titleLabel = UILabel(frame: .zero)
	
	// public setters
	var displayText: String? {
		didSet {
			titleLabel.text = displayText
		}
	}
	
	// inits
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		configureTitleLabel()
	}
	required init?(coder: NSCoder) {
		fatalError("Crash in TitleHeaderView")
	}
	
	// private config methods
	private func configureTitleLabel() {
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.numberOfLines = 2
		titleLabel.font = .preferredFont(forTextStyle: .title2)
		titleLabel.textColor = .white
		addSubview(titleLabel)
		
		titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0).isActive = true
		titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0).isActive = true
		titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
	}
}
