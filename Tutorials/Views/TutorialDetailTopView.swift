//
//  TutorialDetailTopView.swift
//  Tutorials
//
//  Created by Marcus on 7/15/20.
//  Copyright © 2020 Marcus. All rights reserved.
//

import UIKit

class TutorialDetailTopView: UIView {
	// MARK: subview properties
	let tutorialBackgroundView = UIView(frame: .zero)
	let tutorialImageView = UIImageView(frame: .zero)
	private let tutorialStackView = UIStackView(frame: .zero)
	let tutorialTitleLabel = UILabel(frame: .zero)
	let tutorialPublishLabel = UILabel(frame: .zero)
	let tutorialQueueButton = UIButton(frame: .zero)

	
	// MARK: inits
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		configureTutorialSubviews()
		layoutTutorialSubviews()
	}
	required init?(coder: NSCoder) {
		fatalError("Crash in TutorialDetailTopView")
	}
	
	
	// MARK: subview config
	private func configureTutorialSubviews() {
		tutorialBackgroundView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(tutorialBackgroundView)
		
		tutorialImageView.translatesAutoresizingMaskIntoConstraints = false
		tutorialImageView.contentMode = .scaleAspectFit
		addSubview(tutorialImageView)
		
		tutorialStackView.translatesAutoresizingMaskIntoConstraints = false
		tutorialStackView.axis = .vertical
		tutorialStackView.alignment = .leading
		tutorialStackView.distribution = .fill
		tutorialStackView.spacing = 8.0
		
		tutorialTitleLabel.translatesAutoresizingMaskIntoConstraints = false
		tutorialTitleLabel.font = .preferredFont(forTextStyle: .title1)
		tutorialTitleLabel.textColor = .white
		tutorialTitleLabel.numberOfLines = 2
		tutorialStackView.addArrangedSubview(tutorialTitleLabel)
		
		tutorialPublishLabel.translatesAutoresizingMaskIntoConstraints = false
		tutorialPublishLabel.font = .preferredFont(forTextStyle: .body)
		tutorialPublishLabel.textColor = .systemGray
		tutorialPublishLabel.numberOfLines = 1
		tutorialStackView.addArrangedSubview(tutorialPublishLabel)
		
		tutorialQueueButton.translatesAutoresizingMaskIntoConstraints = false
		tutorialQueueButton.setTitle("Add to Queue", for: .normal)
		tutorialQueueButton.setTitleColor(.link, for: .normal)
		tutorialQueueButton.setTitleColor(.white, for: .highlighted)
		tutorialQueueButton.titleLabel?.font = .systemFont(ofSize: 15.0)
		tutorialStackView.addArrangedSubview(tutorialQueueButton)

		addSubview(tutorialStackView)
	}
	private func layoutTutorialSubviews() {
		tutorialBackgroundView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		tutorialBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		tutorialBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		tutorialBackgroundView.heightAnchor.constraint(equalToConstant: 200.0).isActive = true

		tutorialImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		tutorialImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		tutorialImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		tutorialImageView.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
		
		tutorialStackView.topAnchor.constraint(equalTo: tutorialImageView.bottomAnchor, constant: 16.0).isActive = true
		tutorialStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0).isActive = true
		tutorialStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0).isActive = true
		tutorialStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
	}
}
