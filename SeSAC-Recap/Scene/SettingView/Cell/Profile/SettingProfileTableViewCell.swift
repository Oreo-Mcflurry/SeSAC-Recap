//
//  SettingProfileTableViewCell.swift
//  SeSAC-Recap
//
//  Created by A_Mcflurry on 1/21/24.
//

import UIKit

class SettingProfileTableViewCell: UITableViewCell {

	@IBOutlet weak var profileImageBackView: UIView!
	@IBOutlet weak var profileImage: UIImageView!
	@IBOutlet weak var nickNameLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		profileImageBackView.backgroundColor = UIColor(resource: .main)
		DispatchQueue.main.async {
			self.profileImage.layer.cornerRadius = self.profileImage.frame.width / 2
			self.profileImageBackView.layer.cornerRadius = self.profileImage.frame.width / 2
		}
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}

	func setCell() {
		if let userName: String = UserDefaults.standard[.userNickname] {
			nickNameLabel.text = userName
		}

		if let image: String = UserDefaults.standard[.userProfile] {
			profileImage.image = UIImage(named: image)
		}

		if let lists: [String] = UserDefaults.standard[.likeList] {
//			descriptionLabel.text = "\(lists.count)개의 상품을 좋아하고 있어요!"
			let attributedString = NSMutableAttributedString(string: "\(lists.count)개의 상품을 좋아하고 있어요!")

			// Set the color attribute for the count value
			let range = (attributedString.string as NSString).range(of: "\(lists.count)개의 상품")
			attributedString.addAttribute(.foregroundColor, value: UIColor(resource: .main), range: range)

			// Assign the attributed string to the label
			descriptionLabel.attributedText = attributedString
		} else {
			descriptionLabel.text = "좋아요 버튼을 눌러보세요!"
		}

	}

}
