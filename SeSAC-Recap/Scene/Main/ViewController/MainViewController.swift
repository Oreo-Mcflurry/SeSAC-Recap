//
//  MainViewController.swift
//  SeSAC-Recap
//
//  Created by A_Mcflurry on 1/19/24.
//

import UIKit
import Kingfisher

class MainViewController: UIViewController {

	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var tableView: UITableView!
	let alamofireManger = AlamofireCasheManager()
	let emptyImage = UIImageView(image: UIImage.empty)
	let emptyLabel = UILabel()

	override func viewDidLoad() {
		super.viewDidLoad()
		KingfisherManager.shared.cache.memoryStorage.config.totalCostLimit = 512 * 512 * 100
		configureView()
		makeTableView()
		isAppearEmptyView()
		searchBar.delegate = self
	}

	override func viewWillAppear(_ animated: Bool) {
		configureView()
		alamofireManger.clearAlamofireCache()
		KingfisherManager.shared.cache.clearMemoryCache()
	}
	
}

extension MainViewController: UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		if var searchHistory: [String] = UserDefaults.standard[.searchHistory] {
			if !searchHistory.contains(searchBar.text!) {
				searchHistory.insert(searchBar.text!, at: 0)
				UserDefaults.standard[.searchHistory] = searchHistory
			} else {
			  var newHistory = searchHistory.filter( { $0 != searchBar.text! } )
				newHistory.insert(searchBar.text!, at: 0)
				UserDefaults.standard[.searchHistory] = newHistory
			}
		} else {
			UserDefaults.standard[.searchHistory] = ["\(searchBar.text!)"]
		}
		isAppearEmptyView()
		tableView.reloadData()
		navigateResultView()
	}

	func navigateResultView() {
		let sb = UIStoryboard(name: SearchResultViewController.identifier, bundle: nil)
		let vc = sb.instantiateViewController(withIdentifier: SearchResultViewController.identifier) as! SearchResultViewController
		vc.searchText = searchBar.text!
		navigationController?.pushViewController(vc, animated: true)
	}
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
	func makeTableView() {
		tableView.dataSource = self
		tableView.delegate = self

		tableView.rowHeight = 45
		tableView.separatorStyle = .none

		tableView.register(UINib(nibName: SearchHistroyTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SearchHistroyTableViewCell.identifier)
		tableView.register(UINib(nibName: EmptyHistoryTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: EmptyHistoryTableViewCell.identifier)
		tableView.register(UINib(nibName: History1stTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: History1stTableViewCell.identifier)
	}


	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if let data: [String] = UserDefaults.standard[.searchHistory] {
			return data.count == 0 ? 0 : data.count + 1
		} else {
			return 0
		}
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.row == 0 { tableView.reloadRows(at: [indexPath], with: .automatic); return }
		if let searchHistory: [String] = UserDefaults.standard[.searchHistory] {
			searchBar.text = searchHistory[indexPath.row-1]
		}
		navigateResultView()
		isAppearEmptyView()
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.row == 0 {
			let cell = tableView.dequeueReusableCell(withIdentifier: History1stTableViewCell.identifier, for: indexPath) as! History1stTableViewCell
			cell.deleteAllButton.addTarget(self, action: #selector(resetSearchHistory), for: .touchUpInside)
			return cell
		} else {
//			let cell = tableView.dequeueReusableCell(withIdentifier: SearchHistroyTableViewCell.identifier, for: indexPath) as! SearchHistroyTableViewCell
//			if let data: [String] = UserDefaults.standard[.searchHistory] {
//				cell.searchLabel.text = data[indexPath.row-1]
//				cell.deleteButton.tag = indexPath.row
//				cell.deleteButton.addTarget(self, action: #selector(deleteSearchHistory(sender:)), for: .touchUpInside)

			let cell = CodeSearchHistroyTableViewCell()
			cell.deleteButton.addTarget(self, action: #selector(deleteSearchHistory(sender:)), for: .touchUpInside)
			cell.deleteButton.tag = indexPath.row
			if let data: [String] = UserDefaults.standard[.searchHistory] {
				cell.searchLabel.text = data[indexPath.row-1]
			}
			return cell
		}

	}

	@objc func resetSearchHistory() {
		UserDefaults.resetSearchHistory()
		isAppearEmptyView()
		tableView.reloadData()
	}

	@objc func deleteSearchHistory(sender: UIButton) {
		UserDefaults.deleteSearchHistroy(sender.tag-1)
		isAppearEmptyView()
		tableView.reloadData()
	}

	func isAppearEmptyView() {
		if let list: [String] = UserDefaults.standard[.searchHistory] {
			if list.count != 0 {
				emptyImage.removeFromSuperview()
				emptyLabel.removeFromSuperview()
				return
			}
		}
		emptyImage.frame = CGRect(x: 0, y: 0, width: 300, height: 250)
		emptyImage.center = view.center
		view.addSubview(emptyImage)

		emptyLabel.text = "어서 검색해보세요!"
		emptyLabel.textAlignment = .center
		emptyLabel.frame = CGRect(x: 0, y: emptyImage.frame.maxY + 10, width: view.frame.width, height: 30)
		view.addSubview(emptyLabel)
	}
}

extension MainViewController: ConfigureProtocol {
	func configureView() {
		if let nickName: String = UserDefaults.standard[.userNickname] {
			navigationItem.title = "\(nickName)님의 새싹쇼핑"
		}
	}
}
