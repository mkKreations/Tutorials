//
//  QueuedCell.swift
//  Tutorials
//
//  Created by Marcus on 7/16/20.
//  Copyright © 2020 Marcus. All rights reserved.
//

import UIKit

class QueuedCell: UICollectionViewCell {
	static let reuseIdentifier: String = String(describing: self)
	
	
	// MARK: dependencies
	var tutorial: Tutorial? {
		didSet {
			if let queuedTutorial = tutorial {
				queuedImageView.image = UIImage(named: queuedTutorial.thumbnail)
				queuedImageBackgroundView.backgroundColor = UIColor(hexString: queuedTutorial.artworkColor)
			}
		}
	}
	
	
	// MARK: subview properties
	private let queuedImageView = UIImageView(frame: .zero)
	private let queuedImageBackgroundView = UIView(frame: .zero)
	private let labelStackView = UIStackView(frame: .zero)
	private let primaryLabel = UILabel(frame: .zero)
	private let detailLabel = UILabel(frame: .zero)
	private let checkboxImageView = UIImageView(frame: .zero)
	
	
	// MARK: inits
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		configureQueuedSubviews()
		layoutQueuedSubviews()
	}
	required init?(coder: NSCoder) {
		fatalError("Crash in QueuedCell")
	}
	
	
	// MARK: subview config
	private func configureQueuedSubviews() {
		queuedImageBackgroundView.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(queuedImageBackgroundView)
		
		queuedImageView.translatesAutoresizingMaskIntoConstraints = false
		queuedImageView.contentMode = .scaleAspectFit
		contentView.addSubview(queuedImageView)
	}
	private func layoutQueuedSubviews() {
		queuedImageBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0).isActive = true
		queuedImageBackgroundView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
		queuedImageBackgroundView.heightAnchor.constraint(equalToConstant: 96.0).isActive = true
		queuedImageBackgroundView.widthAnchor.constraint(equalToConstant: 96.0).isActive = true
		
		queuedImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0).isActive = true
		queuedImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
		queuedImageView.heightAnchor.constraint(equalToConstant: 96.0).isActive = true
		queuedImageView.widthAnchor.constraint(equalToConstant: 96.0).isActive = true
	}
}
