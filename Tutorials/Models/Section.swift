//
//  Section.swift
//  Tutorials
//
//  Created by Marcus on 7/13/20.
//  Copyright © 2020 Marcus. All rights reserved.
//

import Foundation

struct Section: Hashable {
	let id = UUID() // hashable conformance
	let title: String
	let videos: [Video]
	
	// adding CodingKeys to silence compiler warning
	// id does not need to be decoded - has initial value
	enum CodingKeys: String, CodingKey {
		case title
		case videos
	}
}

// so we can decode data from plist
extension Section: Decodable {}
