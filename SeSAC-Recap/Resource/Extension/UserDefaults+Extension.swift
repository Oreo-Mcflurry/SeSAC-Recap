//
//  Userdefaults+Extension.swift
//  SeSAC-Recap
//
//  Created by A_Mcflurry on 1/18/24.
//

import UIKit

extension UserDefaults {
	enum BoolUserDefaultsKeys: String, CaseIterable {
		case isFirstStart
	}

	enum StringArrayUserDefaultsKeys: String, CaseIterable {
		case searchHistory
		case likeList
	}

	enum StringUserDefaultsKeys: String, CaseIterable {
		case userProfile
		case userNickname
	}

	// 서브스크립트와 제네릭을 섞어서 간단하게 UserDefaults를 쓸 수 있게 구상해보았습니다.
	// +) 근데 어째 이게 더 힘든거같아요 ㅋㅋㅋ 차라리 여러개 만들어서 타입캐스팅을 강제로 할수 있게 할걸 그랬나.. 싶기도 하구요
	// ++) 시도해봤는데 잘 안됩니다..
	subscript(item: BoolUserDefaultsKeys) -> Bool {
		get {
			return UserDefaults.standard.bool(forKey: item.rawValue)
		} set {
			UserDefaults.standard.setValue(newValue, forKey: item.rawValue)
		}
	}

	subscript(item: StringUserDefaultsKeys) -> String {
		get {
			return UserDefaults.standard.string(forKey: item.rawValue) ?? ""
		} set {
			UserDefaults.standard.setValue(newValue, forKey: item.rawValue)
		}
	}

	subscript(item: StringArrayUserDefaultsKeys) -> [String] {
		get {
			return (UserDefaults.standard.array(forKey: item.rawValue) ?? []) as! [String]
		} set {
			UserDefaults.standard.setValue(newValue, forKey: item.rawValue)
		}
	}

	// 츄라이 중 -> 런타임 에러난다..  애초에 뽑을때부터 string이라 해놓고 뽑아야 하는지,,,
//	subscript(item: UserDefaultsKeys) -> String {
//		get {
//			return UserDefaults.standard.value(forKey: item.rawValue) as! String
//		} set {
//			UserDefaults.standard.setValue(newValue, forKey: item.rawValue)
//		}
//	}
//
//	subscript(item: UserDefaultsKeys) -> Bool {
//		get {
//			return UserDefaults.standard.value(forKey: item.rawValue) as! Bool
//		} set {
//			UserDefaults.standard.setValue(newValue, forKey: item.rawValue)
//		}
//	}
//
//	subscript(item: UserDefaultsKeys) -> [String] {
//		get {
//			return UserDefaults.standard.value(forKey: item.rawValue) as! [String]
//		} set {
//			UserDefaults.standard.setValue(newValue, forKey: item.rawValue)
//		}
//	}

	static func resetUserDefaults() {
		for item in BoolUserDefaultsKeys.allCases {
			UserDefaults.standard.removeObject(forKey: item.rawValue)
		}
	}

	static func resetSearchHistory() {
		UserDefaults.standard.removeObject(forKey: StringArrayUserDefaultsKeys.searchHistory.rawValue)
	}

	static func deleteSearchHistroy(_ index: Int) {
		var data = UserDefaults.standard[.searchHistory]
			data.remove(at: index)
			UserDefaults.standard[.searchHistory] = data

	}

	static func isStuffInList(_ id: String) -> String {
		let lists: [String] = UserDefaults.standard[.likeList]
		for list in lists where list == id {
			return "heart.fill"
		}

		//		if let list: [String] = UserDefaults.standard[.likeList] {
		//
		//		}
		return "heart"
	}

	static func likeToggle(_ id: String) {
		var lists: [String] = UserDefaults.standard[.likeList]
		for list in lists where id == list {
			UserDefaults.standard[.likeList]	= lists.filter( { $0 != id })
			return
		}
		lists.insert(id,at:0)
		UserDefaults.standard[.likeList] = lists
		return
	}
}
