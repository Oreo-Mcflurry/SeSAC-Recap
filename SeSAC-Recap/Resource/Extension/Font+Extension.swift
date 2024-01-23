//
//  Font+Extension.swift
//  SeSAC-Recap
//
//  Created by A_Mcflurry on 1/18/24.
//

import UIKit

extension UIFont {
	enum FontSize: Int {
		case title = 17
		case body = 15
		case description = 13
	}

	static func setFont(_ kind: FontSize, isBold: Bool?) -> UIFont {
		if isBold == nil || isBold == false {
			return UIFont.systemFont(ofSize: CGFloat(kind.rawValue))
		} else {
			return UIFont.boldSystemFont(ofSize: CGFloat(kind.rawValue))
		}
	}
}
