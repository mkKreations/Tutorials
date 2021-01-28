//
//  AppDelegate.swift
//  Tutorials
//
//  Created by Marcus on 7/12/20.
//  Copyright © 2020 Marcus. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// tabBarController
		let tabBarController = UITabBarController()
		
		// rootVC config
		let rootVC = HomeViewController()
		rootVC.title = "Library"
		rootVC.tabBarItem = rootVC.homeTabBarItem
		let navVC = UINavigationController(rootViewController: rootVC)

		// queuedVC config
		let queuedVC = QueuedViewController()
		queuedVC.title = "Queue"
		queuedVC.tabBarItem = queuedVC.queuedTabBarItem
		let queuedNavVC = UINavigationController(rootViewController: queuedVC)

		// set rootVC of window
		tabBarController.viewControllers = [navVC, queuedNavVC]
		window?.rootViewController = tabBarController
		window?.makeKeyAndVisible()
		
		return true
	}
	
}
