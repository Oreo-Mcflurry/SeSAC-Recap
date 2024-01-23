//
//  Identifier+Extension.swift
//  SeSAC-Recap
//
//  Created by A_Mcflurry on 1/18/24.
//

import UIKit

extension UITableViewCell: ReusableViewProtocol {
	 static var identifier: String {
		  return String(describing: self)
	 }
}

extension UICollectionReusableView: ReusableViewProtocol {
	 static var identifier: String {
		  return String(describing: self)
	 }
}

extension UIViewController: ReusableViewProtocol {
	 static var identifier: String {
		  return String(describing: self)
	 }
}
