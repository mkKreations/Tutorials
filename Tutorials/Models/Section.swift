//
//  Section.swift
//  Tutorials
//
//  Created by Marcus on 7/13/20.
//  Copyright © 2020 Marcus. All rights reserved.
//

import Foundation

struct Section {
	let title: String
	let videos: [Video]
}

// so we can decode data from plist
extension Section: Codable {}
