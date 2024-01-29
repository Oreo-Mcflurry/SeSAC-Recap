//
//  ProfileView.swift
//  SeSAC-Recap
//
//  Created by A_Mcflurry on 1/29/24.
//

import UIKit
import SnapKit

class ProfileView: UIView, ConfigureView {
	let profilleImageView = UIImageView()
	let imageBackView = UIView()
	let cameraView = UIImageView()
	var isSetting = false

	override init(frame: CGRect) {
		super.init(frame: frame)
		profilleImageView.isUserInteractionEnabled = true
		profilleImageView.layer.cornerRadius = profilleImageView.frame.width / 2

		imageBackView.layer.cornerRadius = imageBackView.frame.width / 2

		cameraView.image = .camera
		cameraView.isUserInteractionEnabled = true
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		profilleImageView.isUserInteractionEnabled = true
		profilleImageView.layer.cornerRadius = profilleImageView.frame.width / 2

		imageBackView.layer.cornerRadius = imageBackView.frame.width / 2

		cameraView.image = .camera
		cameraView.isUserInteractionEnabled = true
	}

	func configureHierarchy() {
		imageBackView.addSubview(profilleImageView)
		self.addSubview(imageBackView)

		if isSetting {
			self.addSubview(cameraView)
		}
	}

	func configureLayout() {
		profilleImageView.snp.makeConstraints {
			$0.center.equalTo(imageBackView.snp.center).inset(10)
		}

		if isSetting {
			cameraView.snp.makeConstraints  {
				$0.bottom.equalTo(imageBackView.snp.bottom)
				$0.leading.equalTo(imageBackView.snp.leading)
				$0.height.width.equalTo(30)
			}
		}
	}

	func configureView() {

	}
}
