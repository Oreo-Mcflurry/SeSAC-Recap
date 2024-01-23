//
//  NumberFormatter+Extension.swift
//  SeSAC-Recap
//
//  Created by A_Mcflurry on 1/20/24.
//

import Foundation

extension NumberFormatter {
	static func getCommaNumber(_ num: Int) -> String {
		let nf = NumberFormatter()
		nf.numberStyle = .decimal
		return nf.string(for: num)!
	}

	static func getCommaNumber(_ num: String) -> String {
		let nf = NumberFormatter()
		nf.numberStyle = .decimal
		let numToInt = Int(num)
		return nf.string(for: numToInt) ?? "0"
	}
}
