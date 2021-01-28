//
//  Tutorial.swift
//  Tutorials
//
//  Created by Marcus on 7/13/20.
//  Copyright © 2020 Marcus. All rights reserved.
//

import Foundation

// since we will be passing instances of this object
// between different views - we'll represent this type
// as a class

final class Tutorial {
	let id = UUID() // Hashable conformance
	let title: String
	let thumbnail: String
	let artworkColor: String
	let publishDate: Date
	var isQueued: Bool
	let content: [Section]
	let updateCount: Int
	
	init(
		title: String,
		thumbnail: String,
		artworkColor: String,
		publishDate: Date,
		isQueued: Bool,
		content: [Section],
		updateCount: Int
	) {
		self.title = title
		self.thumbnail = thumbnail
		self.artworkColor = artworkColor
		self.publishDate = publishDate
		self.isQueued = isQueued
		self.content = content
		self.updateCount = updateCount
	}
	
	// adding CodingKeys to silence compiler warning
	// id does not need to be decoded - has initial value
	enum CodingKeys: String, CodingKey {
		case title
		case thumbnail
		case artworkColor
		case publishDate
		case isQueued
		case content
		case updateCount
	}
}


// Hashable & Equatable conformance
// Hashable inherits from Equatable
extension Tutorial: Hashable {
	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
	static func == (lhs: Tutorial, rhs: Tutorial) -> Bool {
		lhs.id == rhs.id
	}
}

// Decodable conformance
// so we can decode data from plist
extension Tutorial: Decodable {}
