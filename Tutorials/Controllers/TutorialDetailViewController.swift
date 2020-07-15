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
		}
	}
	
	
	// MARK: subview properties
	private let tutorialImageView = UIImageView(frame: .zero)
	private let tutorialStackView = UIStackView(frame: .zero)
	
	
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
		
		tutorialStackView.axis = .vertical
		tutorialStackView.alignment = .leading
		tutorialStackView.distribution = .fill
		tutorialStackView.spacing = 8.0
	}
	private func layoutTutorialSubviews() {
		tutorialImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		tutorialImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		tutorialImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		tutorialImageView.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
		
//		tutorialStackView.topAnchor.constraint(equalTo: tutorialImageView.bottomAnchor, constant: 16.0).isActive = true
////		tutorialStackView.bottomAnchor.constraint(equalTo: tutorialImageView.bottomAnchor, constant: 16.0).isActive = true
//		tutorialStackView.leadingAnchor.constraint(equalTo: tutorialImageView.leadingAnchor, constant: 16.0).isActive = true
//		tutorialStackView.trailingAnchor.constraint(equalTo: tutorialImageView.trailingAnchor, constant: 16.0).isActive = true
	}
}
