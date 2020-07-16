//
//  QueuedViewController.swift
//  Tutorials
//
//  Created by Marcus on 7/15/20.
//  Copyright © 2020 Marcus. All rights reserved.
//

import UIKit

class QueuedViewController: UIViewController {
	// MARK: stored properties
	lazy var queuedTabBarItem: UITabBarItem = {
		UITabBarItem(title: title,
								 image: UIImage(systemName: "bookmark"),
								 selectedImage: UIImage(systemName: "bookmark.fill"))
	}()
	
	
	// MARK: view life cycle methods
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor.red
	}
}
