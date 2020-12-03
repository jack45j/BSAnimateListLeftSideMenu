//
//  SideMenuNavigationViewController.swift
//  Practice Transition
//
//  Created by Yi-Cheng Lin on 2020/12/2.
//

import UIKit

extension UIView {
	func addSubview(_ views: UIView...) {
		for view in views {
			self.addSubview(view)
		}
	}
}



class SideMenuNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationBar.isHidden = true
//		self.navigationItem.setLeftBarButton(UIBarButtonItem(systemItem: .done), animated: true)
    }
}
