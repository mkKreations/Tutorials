//
//  TutorialDetailViewController.swift
//  Tutorials
//
//  Created by Marcus on 7/14/20.
//  Copyright © 2020 Marcus. All rights reserved.
//

import UIKit

class TutorialDetailViewController: UIViewController {
	// MARK: dependencies
	var tutorial: Tutorial! {
		didSet {
			tutorialImageView.image = UIImage(named: tutorial.thumbnail)
			tutorialTitleLabel.text = tutorial.title
			tutorialPublishLabel.text = tutorial.publishDate.formattedPublishDateString
		}
	}
	
	
	// MARK: subview properties
	private let tutorialImageView = UIImageView(frame: .zero)
	private let tutorialStackView = UIStackView(frame: .zero)
	private let tutorialTitleLabel = UILabel(frame: .zero)
	private let tutorialPublishLabel = UILabel(frame: .zero)
	
	
	// MARK: view life cycle methods
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .black
		
		edgesForExtendedLayout = []
		
		configureTutorialSubviews()
		layoutTutorialSubviews()
	}
	
	
	// MARK: view configuration
	private func configureTutorialSubviews() {
		tutorialImageView.translatesAutoresizingMaskIntoConstraints = false
		tutorialImageView.contentMode = .scaleAspectFit
		view.addSubview(tutorialImageView)
		
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
		
		view.addSubview(tutorialStackView)
	}
	private func layoutTutorialSubviews() {
		tutorialImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		tutorialImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		tutorialImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		tutorialImageView.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
		
		tutorialStackView.topAnchor.constraint(equalTo: tutorialImageView.bottomAnchor, constant: 16.0).isActive = true
		tutorialStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0).isActive = true
		tutorialStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0).isActive = true
	}
}
