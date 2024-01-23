//
//  NaverShoppingModel.swift
//  SeSAC-Recap
//
//  Created by A_Mcflurry on 1/20/24.
//

import Foundation

struct NaverShopping: Codable {
	let total: Int
	let items: [Item]

	var getTotalCount: String {
		if total == 0 {
			return "결과가 없습니다"
		} else {
			return "\(NumberFormatter.getCommaNumber(total))개의 검색 결과"
		}
	}
}

struct Item: Codable {
	let title: String?
	let link: String?
	let image: String?
	let lprice, mallName, productID: String?
	let productType: String?
	let brand: String?
	let maker: String?

	enum CodingKeys: String, CodingKey {
		case title, link, image, lprice, mallName
		case productID = "productId"
		case productType, brand, maker
	}

	static let failImage: String = "https://www.shutterstock.com/image-vector/fail-rubber-stamp-red-grunge-260nw-1743161369.jpg"

}
