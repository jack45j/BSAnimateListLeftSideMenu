//
//  MenuViewController.swift
//  Practice Transition
//
//  Created by Yi-Cheng Lin on 2020/12/6.
//

import UIKit

class MenuViewController: UIViewController, SideMenuViewControllerProtocol {
	@IBAction func buttonTap(_ sender: Any) {
		SideMenuManager.shared.dismiss()
	}
	@IBOutlet weak var viewsStackView: UIStackView!
	var views: [UIView] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()
		views = viewsStackView.arrangedSubviews
        // Do any additional setup after loading the view.
    }
}
