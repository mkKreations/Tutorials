//
//  GradientOverlayView.swift
//  Tutorials
//
//  Created by Marcus on 7/13/20.
//  Copyright © 2020 Marcus. All rights reserved.
//

import UIKit

class GradientOverlayView: UIView {
	override init(frame: CGRect) {
		super.init(frame: frame)

		// colors
		let startColor = UIColor(white: 1.0, alpha: 0.0)
		let midColor = UIColor(white: 0.0, alpha: 0.4)
		let endColor = UIColor(white: 0.0, alpha: 0.8)
		
		// locations
		let startLocation: NSNumber = 0.0
		let midLocation: NSNumber = 0.6
		let endLocation: NSNumber = 1.0

		// layer
		let gradient = CAGradientLayer()
		gradient.colors = [startColor.cgColor, midColor.cgColor, endColor.cgColor]
		gradient.locations = [startLocation, midLocation, endLocation]
		gradient.frame = frame
		layer.addSublayer(gradient)
		layer.cornerRadius = 10.0
	}
	required init?(coder: NSCoder) {
		fatalError("Crash in GradientOverlayView")
	}
}
