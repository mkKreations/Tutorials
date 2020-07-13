//
//  Video.swift
//  Tutorials
//
//  Created by Marcus on 7/13/20.
//  Copyright © 2020 Marcus. All rights reserved.
//

import Foundation

struct Video {
	let title: String
	let url: String
}

// so we can decode data from plist
extension Video: Decodable {}
