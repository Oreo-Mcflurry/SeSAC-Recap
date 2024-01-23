//
//  SetProfileViewController.swift
//  SeSAC-Recap
//
//  Created by A_Mcflurry on 1/18/24.
//

import UIKit

class SetProfileViewController: UIViewController {

	var selectedProfile: Profile = .profile1
	var completionHandler: ((Profile) -> ())?

	@IBOutlet private weak var profileBackView: UIView!
	@IBOutlet private weak var profileImage: UIImageView!
	@IBOutlet private weak var collectionView: UICollectionView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureView()
		registerCell()
		setDelegate()
		setLayout()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		completionHandler?(selectedProfile)
	}
}

extension SetProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return Profile.allCases.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		// 혹여나 하는 마음에... 삽질좀 해보았습니다.
//		let kind = Profile.allCases[indexPath.item] == selectedProfile
//		let cellIdentifier = Profile.allCases[indexPath.item] == selectedProfile ? SelectProfileCollectionViewCell.identifier : ProfileCollectionViewCell.identifier
//		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! kind ? SelectProfileCollectionViewCell : ProfileCollectionViewCell
//		return cell

		if Profile.allCases[indexPath.item] == selectedProfile {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectProfileCollectionViewCell.identifier, for: indexPath) as! SelectProfileCollectionViewCell
			cell.setImage(selectedProfile.rawValue)
			return cell
		} else {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.identifier, for: indexPath) as! ProfileCollectionViewCell
			cell.setImage(Profile.allCases[indexPath.item].rawValue)
			return cell
		}
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		selectedProfile = Profile.allCases[indexPath.item]
		profileImage.image = UIImage(named: selectedProfile.rawValue)
		collectionView.reloadData()
	}

	private func registerCell() {
		collectionView.register(UINib(nibName: ProfileCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ProfileCollectionViewCell.identifier)
		collectionView.register(UINib(nibName: SelectProfileCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SelectProfileCollectionViewCell.identifier)
	}

	private func setDelegate() {
		collectionView.delegate = self
		collectionView.dataSource = self
	}

	private func setLayout() {
		let padding: CGFloat = 10
		let layout = UICollectionViewFlowLayout()
		layout.itemSize = CGSize(width: (UIScreen.main.bounds.width-padding*5)/4, height: (UIScreen.main.bounds.width-padding*5)/4)
		layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
		layout.minimumLineSpacing	= padding
		layout.minimumInteritemSpacing = padding
		collectionView.collectionViewLayout = layout
	}

}

extension SetProfileViewController: ConfigureProtocol {
	func configureView() {
		navigationItem.title = "프로필 설정"
		profileBackView.backgroundColor = UIColor(resource: .main)
		profileBackView.layer.cornerRadius = profileBackView.frame.width / 2

		profileImage.image = UIImage(named: selectedProfile.rawValue)
		profileImage.layer.cornerRadius = profileImage.frame.width / 2
	}
}
