//
//  GradientOverlayView.swift
//  Tutorials
//
//  Created by Marcus on 7/13/20.
//  Copyright © 2020 Marcus. All rights reserved.
//

import UIKit

class GradientOverlayView: UIView {
	// MARK: properties
	private let gradientLayer: CAGradientLayer = {
		// colors
		let startColor = UIColor(white: 1.0, alpha: 0.0)
		let midColor = UIColor(white: 0.0, alpha: 0.4)
		let endColor = UIColor(white: 0.0, alpha: 0.8)
		
		// locations
		let startLocation: NSNumber = 0.0
		let midLocation: NSNumber = 0.6
		let endLocation: NSNumber = 1.0

		// gradient
		let gradient = CAGradientLayer()
		gradient.colors = [startColor.cgColor, midColor.cgColor, endColor.cgColor]
		gradient.locations = [startLocation, midLocation, endLocation]
		return gradient
	}()
	
	
	// MARK: inits
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	required init?(coder: NSCoder) {
		fatalError("Crash in GradientOverlayView")
	}
	
	
	// MARK: layer layout
	override func layoutSubviews() {
		super.layoutSubviews()
		
		// only add layer if we have no sublayers
		// we do not want to add it over and over
		if layer.sublayers == nil {
			gradientLayer.frame = bounds // set frame on our layer
			layer.addSublayer(gradientLayer) // add layer as subLayer
			layer.cornerRadius = 10.0 // set corner radius
		}
	}
}
