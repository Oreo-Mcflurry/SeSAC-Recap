//
//  EmptyHistoryTableViewCell.swift
//  SeSAC-Recap
//
//  Created by A_Mcflurry on 1/20/24.
//

import UIKit
import SnapKit

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

// 생각해보니까 이거 애초에 코드베이스로 되어있었는데 왜만들었죠...? ㅋㅋㅋㅋ

class CodeEmptyHistoryTableViewCell: UITableViewCell {
	let emptyImage: UIImageView = {
		let image = UIImageView()
		image.image = .empty
		return image
	}()

	let emptyLabel: UILabel = {
		let label = UILabel()
		label.text = "어서 검색해보세요!"
		return label
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configureHierarchy()
		makeLayout()
	}

	func configureHierarchy() {
		[emptyImage, emptyLabel].forEach { contentView.addSubview($0) }
	}

	func makeLayout() {
		emptyImage.snp.makeConstraints {
			$0.top.horizontalEdges.equalToSuperview()
		}
		emptyLabel.snp.makeConstraints {
			$0.bottom.horizontalEdges.equalToSuperview()
			$0.top.equalTo(emptyImage.snp.bottom).offset(20)
		}
	}

	required init?(coder: NSCoder) {
		fatalError()
	}
}
