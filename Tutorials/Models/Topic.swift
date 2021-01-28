//
//  Topic.swift
//  Tutorials
//
//  Created by Marcus on 7/13/20.
//  Copyright © 2020 Marcus. All rights reserved.
//

import Foundation

struct Topic: Hashable {
	let id = UUID() // hashable conformance
	let title: String
	let tutorials: [Tutorial]
	
	// adding CodingKeys to silence compiler warning
	// id does not need to be decoded - has initial value
	enum CodingKeys: String, CodingKey {
		case title
		case tutorials
	}
}

// so we can decode data from plist
extension Topic: Decodable {}
