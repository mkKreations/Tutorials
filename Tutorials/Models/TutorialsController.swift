//
//  TutorialsController.swift
//  Tutorials
//
//  Created by Marcus on 7/13/20.
//  Copyright © 2020 Marcus. All rights reserved.
//

import Foundation

// this type will be responsible for
// bringing all our model types together

// this type is a class so we can instantiate
// our topics with decoded plist information

class TutorialsController {
	var topics: [Topic]
	// for QueuedViewController
	var queuedTutorials = [Tutorial]()
	
	// singleton
	static let shared = TutorialsController()
	
	// this only executes once using singleton
	private init() {
		// decoding our plist into our model types
		guard let path = Bundle.main.path(forResource: "Tutorials", ofType: "plist"),
					 let xml = FileManager.default.contents(atPath: path),
	  let topicsData = try? PropertyListDecoder().decode([Topic].self, from: xml) else {
			self.topics = [] // default if for whatever reason we can't reach our plist
			return
		}
		topics = topicsData // we decoded our plist so set to internal property
	}
	
	// helper methods
	func queueTutorial(_ tutorial: Tutorial) {
		if tutorial.isQueued {
			queuedTutorials.append(tutorial)
		} else {
			if let removedIndex = queuedTutorials.firstIndex(of: tutorial) {
				queuedTutorials.remove(at: removedIndex)
			}
		}
	}
	func deleteQueuedTutorials(_ tutorials: [Tutorial]) {
		tutorials.forEach { deleteQueuedTutorial($0) }
	}
	private func deleteQueuedTutorial(_ tutorial: Tutorial) {
		if let deleteIndex = queuedTutorials.firstIndex(of: tutorial) {
			tutorial.isQueued = false // remove from queue
			queuedTutorials.remove(at: deleteIndex)
		}
	}
}
