//
//  TutorialCell.swift
//  Tutorials
//
//  Created by Marcus on 7/13/20.
//  Copyright © 2020 Marcus. All rights reserved.
//

import UIKit

class TutorialCell: UICollectionViewCell {
	// reuse identifier
	static let reuseIdentifier: String = String(describing: self)
	
	// MARK: private vars
	private var tutorialImageView: UIImageView!
	private var gradientView: GradientOverlayView!
	private var tutorialLabel: UILabel!
	
	
	// MARK: public setters
	var tutorialImageName: String? {
		didSet {
			if let imageName = tutorialImageName {
				tutorialImageView.image = UIImage(named: imageName)
			}
		}
	}
	var tutorialText: String? {
		didSet {
			tutorialLabel.text = tutorialText
		}
	}
	var tutorialBackgroundColor: String? {
		didSet {
			if let hexString = tutorialBackgroundColor {
				contentView.backgroundColor = UIColor(hexString: hexString)
			}
		}
	}
	
	
	// MARK: inits
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		contentView.layer.cornerRadius = 10.0
		contentView.clipsToBounds = true
		
		instantiateTutorialViews()
		layoutTutorialViews()
	}
	required init?(coder: NSCoder) {
		fatalError("Crash in TutorialCell")
	}
	
	
	// MARK: helper methods
	private func instantiateTutorialViews() {
		tutorialImageView = UIImageView(frame: .zero)
		tutorialImageView.translatesAutoresizingMaskIntoConstraints = false
		tutorialImageView.contentMode = .scaleAspectFill
		tutorialImageView.clipsToBounds = true
		contentView.addSubview(tutorialImageView)
		
		gradientView = GradientOverlayView(frame: .zero)
		gradientView.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(gradientView)
		
		tutorialLabel = UILabel(frame: .zero)
		tutorialLabel.translatesAutoresizingMaskIntoConstraints = false
		tutorialLabel.font = .preferredFont(forTextStyle: .title3)
		tutorialLabel.textColor = .white
		tutorialLabel.numberOfLines = 2
		contentView.addSubview(tutorialLabel)
	}
	private func layoutTutorialViews() {
		tutorialImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
		tutorialImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
		tutorialImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		tutorialImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
		
		gradientView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
		gradientView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
		gradientView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		gradientView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
		
		tutorialLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0).isActive = true
		tutorialLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0).isActive = true
		tutorialLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16.0).isActive = true
	}
}
