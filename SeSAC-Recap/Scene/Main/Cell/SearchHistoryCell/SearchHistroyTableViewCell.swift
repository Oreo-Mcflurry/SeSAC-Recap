//
//  SearchHistroyTableViewCell.swift
//  SeSAC-Recap
//
//  Created by A_Mcflurry on 1/20/24.
//

import UIKit
import SnapKit

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

class CodeSearchHistroyTableViewCell: UITableViewCell, ConfigureView {
	let searchImageView = UIImageView()
	let searchLabel = UILabel()
	let deleteButton = UIButton()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		configureHierarchy()
		configureLayout()
		configureView()
	}

	required init?(coder: NSCoder) {
		fatalError()
	}

	func configureHierarchy() {
		[searchLabel, searchImageView, deleteButton].forEach { contentView.addSubview($0) }
	}

	func configureLayout() {
		searchImageView.snp.makeConstraints {
			$0.width.equalTo(20)
			$0.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
			$0.leading.equalTo(20)
		}

		searchLabel.snp.makeConstraints {
			$0.leading.equalTo(searchImageView.snp.trailing).offset(10)
			$0.verticalEdges.equalTo(contentView.safeAreaLayoutGuide)
			$0.trailing.greaterThanOrEqualTo(deleteButton.snp.leading)
		}

		deleteButton.snp.makeConstraints {
			$0.verticalEdges.equalTo(contentView.safeAreaLayoutGuide)
			$0.trailing.equalTo(-20)
		}
	}

	func configureView() {
		searchImageView.image = UIImage(systemName: "magnifyingglass")
		searchImageView.tintColor = .white

		deleteButton.setImage(UIImage(systemName: "xmark"), for: .normal)
		deleteButton.tintColor = .white
	}

}
