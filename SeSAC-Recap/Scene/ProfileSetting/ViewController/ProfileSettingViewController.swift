//
//  ProfileSettingViewController.swift
//  SeSAC-Recap
//
//  Created by A_Mcflurry on 1/18/24.
//

import UIKit

class ProfileSettingViewController: UIViewController {

//	@IBOutlet weak var profileImage: UIImageView!
//	@IBOutlet weak var imageBackView: UIView!

	let profileImage = ProfileView()
//	@IBOutlet weak var cameraImage: UIImageView!
	@IBOutlet weak var enterNicknameTextField: UITextField!
	@IBOutlet weak var statusLabel: UILabel!
	@IBOutlet weak var completeButton: UIButton!

	var currentUserProfile: Profile = Profile.allCases.randomElement()! {
		didSet {
			profileImage.profilleImageView.image = UIImage(named: self.currentUserProfile.rawValue)
		}
	}

	var isComplete: Bool = false {
		didSet {
			completeButton.isEnabled = isComplete
			completeButton.backgroundColor = isComplete ? UIColor(resource: .main) : .gray
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		configureView()
		nickNameEditing(enterNicknameTextField)
	}

	@IBAction func tapCompleteButton(_ sender: UIButton) {
		UserDefaults.standard[.userNickname] = enterNicknameTextField.text!
		UserDefaults.standard[.userProfile] = currentUserProfile.rawValue
		if let _: Bool = UserDefaults.standard[.isFirstStart] {
			navigationController?.popViewController(animated: true)
		} else {
			UserDefaults.standard[.isFirstStart] = true
			let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
			let sceneDelgate = windowScene?.delegate as? SceneDelegate
			let sb = UIStoryboard(name: "Main", bundle: nil)
			let vc = sb.instantiateViewController(withIdentifier: "tabView") as! TabViewController
			sceneDelgate?.window?.rootViewController = vc
			sceneDelgate?.window?.makeKeyAndVisible()

		}
	}

	@IBAction func setProfile(_ sender: UITapGestureRecognizer) {
		let vc = storyboard?.instantiateViewController(identifier: SetProfileViewController.identifier) as! SetProfileViewController
		vc.selectedProfile = currentUserProfile
		vc.completionHandler = { item in
			self.currentUserProfile = item
		}
		navigationController?.pushViewController(vc, animated: true)
	}
	@IBAction func endEdit(_ sender: Any) {
		view.endEditing(true)
	}

	@IBAction func nickNameEditing(_ sender: UITextField) {
		if !(2..<10 ~= sender.text!.count) {
			statusLabel.text = "2글자 이상 10글자 미만으로 설정해주세요"
			isComplete = false
			return
		}

		if Int(sender.text!.filter( { $0.isNumber } )) != nil {
			statusLabel.text = "닉네임에 숫자를 포함할 수 없어요"
			isComplete = false
			return
		}

		if sender.text!.contains("@") || sender.text!.contains("#") || sender.text!.contains("$") || sender.text!.contains("%") {
			statusLabel.text = "닉네임에 @, #, $, %에 포함할 수 없어요"
			isComplete = false
			return
		}

		statusLabel.text = "닉네임을 사용할 수 있어요!"
		isComplete = true

	}
}

// 잘 몰랐던 문법들을 최대한 많이 써보려고 합니다. 서브스크립트, 제네릭, where절 같은 애들.
extension ProfileSettingViewController: ConfigureProtocol {
	func configureView() {
		if let nickName: String = UserDefaults.standard[.userNickname] { enterNicknameTextField.text! = nickName }
		if let profile: String = UserDefaults.standard[.userProfile] {
			for item in Profile.allCases where item.rawValue == profile { self.currentUserProfile = item }
		}
		profileImage.profilleImageView.image = UIImage(named: currentUserProfile.rawValue)
		navigationItem.title = "프로필 설정"

//		profileImage.layer.cornerRadius = profileImage.frame.width / 2
//		profileImage.isUserInteractionEnabled = true

//		cameraImage.image = .camera
//		cameraImage.isUserInteractionEnabled = true

//		imageBackView.layer.cornerRadius = imageBackView.frame.width / 2
//		imageBackView.backgroundColor = UIColor(resource: .main)
		
		completeButton.layer.cornerRadius = 10
		completeButton.backgroundColor = UIColor(resource: .main)
		completeButton.titleLabel?.textColor = UIColor(resource: .text)
		completeButton.setTitle("완료", for: .normal)
	}
}
