//
//  Tutorial.swift
//  Tutorials
//
//  Created by Marcus on 7/13/20.
//  Copyright © 2020 Marcus. All rights reserved.
//

import Foundation

struct Tutorial: Hashable {
	let id = UUID() // Hashable conformance
	let title: String
	let thumbnail: String
	let artworkColor: String
	let publishDate: Date
	let isQueued: Bool
	let content: [Section]
	let updateCount: Int
}

// so we can decode data from plist
extension Tutorial: Decodable {}
