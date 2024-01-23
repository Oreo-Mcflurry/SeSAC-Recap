//
//  AlamofireCasheManager.swift
//  SeSAC-Recap
//
//  Created by A_Mcflurry on 1/20/24.
//

import Foundation
import Alamofire

class AlamofireCasheManager {
	func clearAlamofireCache() {
		 // Alamofire 캐시 매니저 생성
		 let cache = Alamofire.Session.default.sessionConfiguration.urlCache

		 // 캐시를 제거하고 새로운 빈 캐시를 할당
		 cache?.removeAllCachedResponses()
		 let newCache = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
		 Alamofire.Session.default.sessionConfiguration.urlCache = newCache
	}
}
