//
//  UIColor+extensions.swift
//  Tutorials
//
//  Created by Marcus on 7/14/20.
//  Copyright © 2020 Marcus. All rights reserved.
//

import UIKit

extension UIColor {
	// failable init since we're checking a string value
	// as well as an array count
	convenience init?(hexString: String) {
    var chars = Array(hexString.hasPrefix("#") ? hexString.dropFirst() : hexString[...])
    let red, green, blue, alpha: CGFloat

    switch chars.count {
    case 3:
      chars = chars.flatMap { [$0, $0] }
      fallthrough
    case 6:
      chars = ["F","F"] + chars
      fallthrough
    case 8:
      alpha = CGFloat(strtoul(String(chars[0...1]), nil, 16)) / 255
      red   = CGFloat(strtoul(String(chars[2...3]), nil, 16)) / 255
      green = CGFloat(strtoul(String(chars[4...5]), nil, 16)) / 255
      blue  = CGFloat(strtoul(String(chars[6...7]), nil, 16)) / 255
    default:
			// if prefix isn't found or array count doesn't match
			return nil
    }
		// init using designated init once we obtained our values
    self.init(red: red, green: green, blue:  blue, alpha: alpha)
	}
}
