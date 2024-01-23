//
//  SelectProfileCollectionViewCell.swift
//  SeSAC-Recap
//
//  Created by A_Mcflurry on 1/18/24.
//

import UIKit

class SelectProfileCollectionViewCell: UICollectionViewCell {

	@IBOutlet weak var imageBackView: UIView!
	@IBOutlet weak var image: UIImageView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		imageBackView.backgroundColor = UIColor(resource: .main)
		DispatchQueue.main.async {
			self.imageBackView.layer.cornerRadius = self.imageBackView.frame.width / 2
			self.image.layer.cornerRadius = self.image.frame.width / 2
		}
	}

	func setImage(_ imageName: String) {
		image.image = UIImage(named: imageName)
	}
}
