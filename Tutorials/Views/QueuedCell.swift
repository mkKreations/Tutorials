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
			// these properties don't need to be unwrapped to be set
			primaryLabel.text = tutorial?.title
			detailLabel.text = tutorial?.publishDate.formattedPublishDateString
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
		
		labelStackView.translatesAutoresizingMaskIntoConstraints = false
		labelStackView.axis = .vertical
		labelStackView.distribution = .fill
		labelStackView.alignment = .leading
		labelStackView.spacing = 8.0
		
		primaryLabel.translatesAutoresizingMaskIntoConstraints = false
		primaryLabel.font = .preferredFont(forTextStyle: .title2)
		primaryLabel.textColor = .white
		primaryLabel.numberOfLines = 2
		labelStackView.addArrangedSubview(primaryLabel)
		
		detailLabel.translatesAutoresizingMaskIntoConstraints = false
		detailLabel.font = .preferredFont(forTextStyle: .body)
		detailLabel.textColor = .lightGray
		detailLabel.numberOfLines = 1
		labelStackView.addArrangedSubview(detailLabel)
		
		contentView.addSubview(labelStackView)
		
		checkboxImageView.translatesAutoresizingMaskIntoConstraints = false
		checkboxImageView.image = UIImage(systemName: "checkmark.circle")
		checkboxImageView.isHidden = true
		contentView.addSubview(checkboxImageView)
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
		
		// setting stackView size based on imageView
		labelStackView.leadingAnchor.constraint(equalTo: queuedImageView.trailingAnchor, constant: 16.0).isActive = true
		labelStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
		labelStackView.topAnchor.constraint(equalTo: queuedImageView.topAnchor).isActive = true
		labelStackView.bottomAnchor.constraint(lessThanOrEqualTo: queuedImageView.bottomAnchor).isActive = true
		
		checkboxImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0).isActive = true
		checkboxImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16.0).isActive = true
	}
}
