//
//  Topic.swift
//  Tutorials
//
//  Created by Marcus on 7/13/20.
//  Copyright © 2020 Marcus. All rights reserved.
//

import Foundation

struct Topic {
	let title: String
	let tutorials: [Tutorial]
}

// so we can decode data from plist
extension Topic: Codable {}
