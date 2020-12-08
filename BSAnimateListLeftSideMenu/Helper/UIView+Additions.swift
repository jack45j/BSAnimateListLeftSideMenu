//
//  UIView+Additions.swift
//  Practice Transition
//
//  Created by Yi-Cheng Lin on 2020/12/5.
//

import UIKit

extension UIView {
	func addSubview(_ views: UIView...) {
		for view in views {
			self.addSubview(view)
		}
	}
}
