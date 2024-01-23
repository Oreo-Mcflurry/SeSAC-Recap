//
//  OnboardingViewController.swift
//  SeSAC-Recap
//
//  Created by A_Mcflurry on 1/18/24.
//

import UIKit

class OnboardingViewController: UIViewController {

	@IBOutlet weak var onboardingLabel: UILabel!
	@IBOutlet weak var onboardingImage: UIImageView!
	@IBOutlet weak var nextButon: UIButton!

	override func viewDidLoad() {
		super.viewDidLoad()
		configureView()
		UserDefaults.resetUserDefaults()
	}

	@IBAction func pressNextButton(_ sender: UIButton) {
		let sb = UIStoryboard(name: ProfileSettingViewController.identifier, bundle: nil)
		let vc = sb.instantiateViewController(withIdentifier: ProfileSettingViewController.identifier)

		navigationController?.pushViewController(vc, animated: true)
	}
}

extension OnboardingViewController: ConfigureProtocol {
	func configureView() {
		onboardingLabel.text = "SeSAC\nShopping"
		onboardingLabel.textAlignment = .center
		onboardingLabel.numberOfLines = 2
		onboardingLabel.textColor = UIColor(resource: .main)

		onboardingImage.image = .onboarding
		onboardingImage.contentMode = .scaleAspectFill

		nextButon.setTitle("시작하기", for: .normal)
		nextButon.titleLabel?.font = UIFont.setFont(.title, isBold: true)
		nextButon.backgroundColor = UIColor(resource: .main)
		nextButon.tintColor = UIColor(resource: .text)
		nextButon.layer.cornerRadius = 10
	}
}
