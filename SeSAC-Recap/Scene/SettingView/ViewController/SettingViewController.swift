//
//  SettingViewController.swift
//  SeSAC-Recap
//
//  Created by A_Mcflurry on 1/21/24.
//

import UIKit

class SettingViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	override func viewDidLoad() {
		super.viewDidLoad()
		configureView()
		setTableView()
		tableView.rowHeight = UITableView.automaticDimension
	}

	override func viewWillAppear(_ animated: Bool) {
		tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
	}
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return section == 0 ? 1 : SettingTable.allCases.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.section == 0 {
			let cell = tableView.dequeueReusableCell(withIdentifier: SettingProfileTableViewCell.identifier, for: indexPath) as! SettingProfileTableViewCell
			cell.setCell()
			return cell
		} else {
			let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as! SettingTableViewCell
			cell.setCell(SettingTable.allCases[indexPath.row].rawValue)
			return cell
		}
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.section == 0 {
			let sb = UIStoryboard(name: ProfileSettingViewController.identifier, bundle: nil)
			let vc = sb.instantiateViewController(identifier: ProfileSettingViewController.identifier)
			navigationController?.pushViewController(vc, animated: true)
		} else if indexPath.section == 1 && indexPath.row == SettingTable.allCases.count - 1 {
			let alert = UIAlertController(title: "초기화 하시겠습니까?", message: "확인을 누르시면 초기화 됩니다.", preferredStyle: .alert)
			let cancel = UIAlertAction(title: "취소", style: .cancel)
			let button = UIAlertAction(title: "확인", style: .default) { _ in
				UserDefaults.resetUserDefaults()
				let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
				let sceneDelgate = windowScene?.delegate as? SceneDelegate
				let sb = UIStoryboard(name: "OnboardingViewController", bundle: nil)
				let vc = sb.instantiateViewController(withIdentifier: "UINaviViewController") as! UINaviViewController
				sceneDelgate?.window?.rootViewController = vc
				sceneDelgate?.window?.makeKeyAndVisible()
			}
			alert.addAction(cancel)
			alert.addAction(button)
			present(alert, animated: true)
		}
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}

	func setTableView() {
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(UINib(nibName: SettingProfileTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SettingProfileTableViewCell.identifier)
		tableView.register(UINib(nibName: SettingTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SettingTableViewCell.identifier)
	}
}

extension SettingViewController: ConfigureProtocol {
	func configureView() {
		navigationItem.title = "설정"
	}
}
