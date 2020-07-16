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
		let tabBarController = UITabBarController()
		let rootVC = HomeViewController()
		let navVC = UINavigationController(rootViewController: rootVC)
		tabBarController.viewControllers = [navVC]
		window?.rootViewController = tabBarController
		window?.makeKeyAndVisible()
		return true
	}
}
