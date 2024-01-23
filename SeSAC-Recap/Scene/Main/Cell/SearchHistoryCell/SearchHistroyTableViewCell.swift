//
//  SearchHistroyTableViewCell.swift
//  SeSAC-Recap
//
//  Created by A_Mcflurry on 1/20/24.
//

import UIKit

class SearchHistroyTableViewCell: UITableViewCell {

	@IBOutlet weak var searchImage: UIImageView!
	@IBOutlet weak var searchLabel: UILabel!
	@IBOutlet weak var deleteButton: UIButton!

	override func awakeFromNib() {
		super.awakeFromNib()
		searchImage.image = UIImage(systemName: "magnifyingglass")?.withTintColor(.white)
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}

	func setCell(_ history: String) {
		searchLabel.text = history
	}
}
