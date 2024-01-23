//
//  SettingTableViewCell.swift
//  SeSAC-Recap
//
//  Created by A_Mcflurry on 1/21/24.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

	@IBOutlet weak var titleLabel: UILabel!
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}

	func setCell(_ kind: String) {
		titleLabel.text = kind
	}

}
