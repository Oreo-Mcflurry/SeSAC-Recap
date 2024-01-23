//
//  History1stTableViewCell.swift
//  SeSAC-Recap
//
//  Created by A_Mcflurry on 1/20/24.
//

import UIKit

class History1stTableViewCell: UITableViewCell {

	@IBOutlet weak var label: UILabel!
	@IBOutlet weak var deleteAllButton: UIButton!
	override func awakeFromNib() {
		super.awakeFromNib()
		label.text = "최근 검색"
		label.font = UIFont.setFont(.body, isBold: nil)
		label.textColor = UIColor(resource: .text)

		deleteAllButton.setTitle("모두 지우기", for: .normal)
		deleteAllButton.titleLabel?.font = UIFont.setFont(.body, isBold: nil)
		deleteAllButton.setTitleColor(UIColor(resource: .main), for: .normal)
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}

}
