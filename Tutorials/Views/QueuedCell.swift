//
//  QueuedCell.swift
//  Tutorials
//
//  Created by Marcus on 7/16/20.
//  Copyright © 2020 Marcus. All rights reserved.
//

import UIKit

class QueuedCell: UICollectionViewCell {
	// MARK: reuseIdentifier
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
	private let imageViewSizeConstant: CGFloat = 96.0
	
	
	// MARK: inits
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		contentView.backgroundColor = .darkGray
		contentView.layer.cornerRadius = 10.0
		
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
		queuedImageBackgroundView.widthAnchor.constraint(equalToConstant: imageViewSizeConstant).isActive = true
		queuedImageBackgroundView.heightAnchor.constraint(equalTo: queuedImageBackgroundView.widthAnchor).isActive = true

		queuedImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0).isActive = true
		queuedImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
		queuedImageView.heightAnchor.constraint(equalTo: queuedImageView.widthAnchor).isActive = true
		queuedImageView.widthAnchor.constraint(equalToConstant: imageViewSizeConstant).isActive = true
	}
}
