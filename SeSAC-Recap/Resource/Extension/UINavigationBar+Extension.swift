//
//  UINavigationBar+Extension.swift
//  SeSAC-Recap
//
//  Created by A_Mcflurry on 1/18/24.
//

import UIKit

extension UINavigationController {
  open override func viewWillLayoutSubviews() {
	 navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
  }
}
