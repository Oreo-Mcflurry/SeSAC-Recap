//
//  WebViewController.swift
//  SeSAC-Recap
//
//  Created by A_Mcflurry on 1/21/24.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

	var stuffName: String = ""
	var stuffID: String = ""
	@IBOutlet weak var webView: WKWebView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureView()
	}
}

extension WebViewController: ConfigureProtocol {
	func configureView() {
		navigationItem.title = stuffName.htmlEscaped
		webView.load(URLRequest(url: URL(string: "https://msearch.shopping.naver.com/product/\(stuffID)")!))

		let button = UIBarButtonItem(image: UIImage(systemName: UserDefaults.isStuffInList(stuffID)), style: .plain, target: self, action: #selector(tapHeartButton))
		navigationItem.rightBarButtonItem = button
	}

	@objc func tapHeartButton() {
		UserDefaults.likeToggle(stuffID)
		checkLiked()
	}

	func checkLiked() {
		navigationItem.rightBarButtonItem?.image = UIImage(systemName: UserDefaults.isStuffInList(stuffID))
	}
}
