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
			topView.tutorialImageView.image = UIImage(named: tutorial.thumbnail)
			topView.tutorialTitleLabel.text = tutorial.title
			topView.tutorialPublishLabel.text = tutorial.publishDate.formattedPublishDateString
			topView.tutorialBackgroundView.backgroundColor = UIColor(hexString: tutorial.artworkColor)
		}
	}
	
	
	// MARK: subview properties
	private let topView = TutorialDetailTopView(frame: .zero)
	// passing in default collectionViewLayout for instantiation
	private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
	
	
	// MARK: view life cycle methods
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = tutorial.title
		navigationController?.navigationBar.prefersLargeTitles = false

		view.backgroundColor = .black
		
		edgesForExtendedLayout = []
		
		configureTutorialSubviews()
		layoutTutorialSubviews()
	}
	
	
	// MARK: actions
	@objc private func queueButtonPressed(_ sender: UIButton) {
		print("queue button pressed!")
	}
	
	
	// MARK: view configuration
	private func configureTutorialSubviews() {
		topView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(topView)
		
		// become target for queue button
		topView.tutorialQueueButton.addTarget(self, action: #selector(queueButtonPressed), for: .touchUpInside)
		
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.backgroundColor = .systemIndigo
		view.addSubview(collectionView)
	}
	private func layoutTutorialSubviews() {
		topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

		collectionView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 16.0).isActive = true
		collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 6.0).isActive = true
		collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -6.0).isActive = true
		collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 6.0).isActive = true
	}
}
