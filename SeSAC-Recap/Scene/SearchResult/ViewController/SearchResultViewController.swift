//
//  SearchResultViewController.swift
//  SeSAC-Recap
//
//  Created by A_Mcflurry on 1/20/24.
//

import UIKit
import Alamofire
import Kingfisher

class SearchResultViewController: UIViewController {
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var resultCountLabel: UILabel!
	@IBOutlet var filterButtons: [UIButton]!

	var searchText: String = ""
	var page = 0
	var start: String {
		return "\((page*30)+1)"
	}
	var items: [Item] = []
	var selected: Int = 0 {
		didSet {
			for (index, item) in filterButtons.enumerated() where selected != index {
				item.backgroundColor = .black
				item.tintColor = .white
			}
			filterButtons[selected].backgroundColor = .white
			filterButtons[selected].tintColor = .black
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		configureView()
		setCollectionViewLayout()
		setCollectionDelegate()
	}

	override func viewWillAppear(_ animated: Bool) {
		callSearchResult(searchText, .accuracy, withStart: start)
	}

	@IBAction func tapFilterButton(_ sender: UIButton) {
		if selected != sender.tag {
			selected = sender.tag
			self.collectionView.setContentOffset(CGPoint(x:0,y:0), animated: false)
			KingfisherManager.shared.cache.clearMemoryCache()
			page = 0
			callSearchResult(searchText, SearchSortKind.allCases[sender.tag], withStart: start)
		}
	}
}

extension SearchResultViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDataSourcePrefetching {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return items.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResltCollectionViewCell.identifier, for: indexPath) as! SearchResltCollectionViewCell
		cell.setCell(items[indexPath.item])
		cell.completionHandler = {
			UserDefaults.likeToggle(self.items[indexPath.item].productID ?? "")
			collectionView.reloadItems(at: [indexPath])
		}
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let sb = UIStoryboard(name: WebViewController.identifier, bundle: nil)
		let vc = sb.instantiateViewController(withIdentifier: WebViewController.identifier) as! WebViewController
		
		vc.stuffName = items[indexPath.item].title ?? ""
		vc.stuffID = items[indexPath.item].productID ?? ""

		navigationController?.pushViewController(vc, animated: true)
	}

	func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
		for item in indexPaths where item.row == items.count - 3 {
			page += 1
			callSearchResult(searchText, SearchSortKind.allCases[selected], withStart: start)
		}
	}

	func setCollectionDelegate() {
		collectionView.register(UINib(nibName: SearchResltCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SearchResltCollectionViewCell.identifier)
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.prefetchDataSource = self
	}

	func setCollectionViewLayout() {
		let layout = UICollectionViewFlowLayout()
		let padding: CGFloat = 20
		layout.itemSize = CGSize(width: (UIScreen.main.bounds.width-padding*3)/2, height: 300)
		layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
		layout.minimumLineSpacing = padding
		layout.minimumInteritemSpacing = padding
		collectionView.collectionViewLayout = layout
	}
}

extension SearchResultViewController: ConfigureProtocol {
	func configureView() {
		navigationItem.title = searchText

		resultCountLabel.font = UIFont.setFont(.body, isBold: true)
		resultCountLabel.textColor = UIColor(resource: .main)

		for (index, item) in filterButtons.enumerated() {
			item.setTitle(SearchSortKind.allCases[index].getButtonName, for: .normal)
			item.layer.cornerRadius = 10
			item.layer.borderColor = UIColor.white.cgColor
			item.layer.borderWidth = 1
			item.tag = index
		}
		filterButtons[0].backgroundColor = .white
		filterButtons[0].tintColor = .black
	}
}

extension SearchResultViewController {
	enum SearchSortKind: String, CaseIterable {
		case accuracy = "sim" // 정확도순으로
		case date // 날짜순으로 내림차순 정렬
		case priceHigher = "dsc" // 가격순으로 오름차순 정렬
		case priceLower = "asc"// 가격순으로 내림차순 정렬

		var getButtonName: String {
			switch self {
			case .accuracy: return "정확도"
			case .date: return "날짜순"
			case .priceHigher: return "가격높은순"
			case .priceLower: return "가격낮은순"
			}
		}
	}

	func callSearchResult(_ searhText: String, _ sort: SearchSortKind, withStart start: String) {
		let url = "https://openapi.naver.com/v1/search/shop.json?query=\(searchText)&display=30&start=\(start)&sort=\(sort.rawValue)"
		let header: HTTPHeaders = [
			"Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
			"X-Naver-Client-Id": APIKeys.naverClient.rawValue,
			"X-Naver-Client-Secret": APIKeys.naverClientSecret.rawValue,
		]

		AF.request(url, headers: header).responseDecodable(of: NaverShopping.self) { response in
			switch response.result {
			case .success(let success):
				if self.page == 0 {
					self.items = success.items
					self.resultCountLabel.text = success.getTotalCount
				} else {
					self.items.append(contentsOf: success.items)
				}
				self.collectionView.reloadData()
			case .failure(_):
				self.resultCountLabel.text = "통신을 실패했습니다."
			}
		}
	}
}
