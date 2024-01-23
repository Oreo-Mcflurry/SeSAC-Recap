//
//  SearchResltCollectionViewCell.swift
//  SeSAC-Recap
//
//  Created by A_Mcflurry on 1/20/24.
//

import UIKit
import Kingfisher

class SearchResltCollectionViewCell: UICollectionViewCell {

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var brandLabel: UILabel!
	@IBOutlet weak var priceLabel: UILabel!
	@IBOutlet weak var likeButton: UIButton!
	var completionHandler: (()->Void)?

	override func awakeFromNib() {
		super.awakeFromNib()
		imageView.layer.cornerRadius = 10
		imageView.contentMode = .scaleAspectFill

		brandLabel.textColor = .lightGray
		brandLabel.font = UIFont.setFont(.description, isBold: nil)

		titleLabel.textColor = .gray
		titleLabel.font = UIFont.setFont(.body, isBold: nil)
		titleLabel.numberOfLines = 2

		priceLabel.textColor = .white
		priceLabel.font = UIFont.setFont(.title, isBold: nil)
		DispatchQueue.main.async {
			self.likeButton.layer.cornerRadius = self.likeButton.bounds.width / 2
			self.likeButton.setTitle("", for: .normal)
			self.likeButton.backgroundColor = .white
			self.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
			self.likeButton.tintColor = .black
		}
	}

	func setCell(_ item: Item) {
		let imageURL = URL(string: item.image ?? Item.failImage)

		// 이미지를 low-quality로 가져오기 위한 ImageProcessor 정의
		let processor = DownsamplingImageProcessor(size: CGSize(width: 50, height: 50))
			 |> ResizingImageProcessor(referenceSize: CGSize(width: 50, height: 50), mode: .aspectFill)

		// KingfisherOptionsInfo를 사용하여 이미지 프로세싱 옵션 설정
		let options: KingfisherOptionsInfo = [
			 .processor(processor),
			 .scaleFactor(UIScreen.main.scale),
			 .transition(.fade(1)),
			 .cacheOriginalImage
		]

		// 이미지를 가져와서 imageView에 설정
		imageView.kf.setImage(
			 with: imageURL,
			 placeholder: nil,
			 options: options,
			 progressBlock: nil,
			 completionHandler: nil
		)
		titleLabel.text = item.title?.htmlEscaped
		brandLabel.text = item.maker?.htmlEscaped
		priceLabel.text = NumberFormatter.getCommaNumber(item.lprice ?? "0")

		likeButton.setImage(UIImage(systemName: UserDefaults.isStuffInList(item.productID ?? "")), for: .normal)
	}

	@IBAction func likeButtonClicked(_ sender: UIButton) {
		completionHandler?()
	}
}

