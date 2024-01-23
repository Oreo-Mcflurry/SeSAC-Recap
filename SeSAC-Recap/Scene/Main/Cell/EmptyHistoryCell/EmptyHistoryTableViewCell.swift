//
//  EmptyHistoryTableViewCell.swift
//  SeSAC-Recap
//
//  Created by A_Mcflurry on 1/20/24.
//

import UIKit

class EmptyHistoryTableViewCell: UITableViewCell {

	@IBOutlet weak var emptyImage: UIImageView!
	@IBOutlet weak var emptyLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		emptyImage.image = .empty
		emptyLabel.font = UIFont.setFont(.title, isBold: true)
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}

}
