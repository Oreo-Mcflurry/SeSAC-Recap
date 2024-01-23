//
//  ProfileCollectionViewCell.swift
//  SeSAC-Recap
//
//  Created by A_Mcflurry on 1/18/24.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {

	@IBOutlet weak var image: UIImageView!
	override func awakeFromNib() {
		super.awakeFromNib()
		DispatchQueue.main.async {
			self.image.layer.cornerRadius = self.image.frame.width / 2
		}
	}

	func setImage(_ imageName: String) {
		image.image = UIImage(named: imageName)
	}
}
