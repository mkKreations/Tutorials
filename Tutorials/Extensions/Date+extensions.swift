//
//  Date+extensions.swift
//  Tutorials
//
//  Created by Marcus on 7/15/20.
//  Copyright © 2020 Marcus. All rights reserved.
//

import Foundation

extension Date {
	var formattedPublishDateString: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MMM d, yyyy" // Jul 15, 2020
		return dateFormatter.string(from: self)
	}
}
