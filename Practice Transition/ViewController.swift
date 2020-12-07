//
//  ViewController.swift
//  Practice Transition
//
//  Created by Yi-Cheng Lin on 2020/12/2.
//

import UIKit

class ViewController: UIViewController {

	let firstButton: UIButton! = UIButton(type: .close)
	let firstLabel: UILabel! = UILabel()
	let secondLabel: UILabel! = UILabel()
	let thirdLabel: UILabel! = UILabel()
	let fourthLabel: UILabel! = UILabel()
	let fifthLabel: UILabel! = UILabel()
	let sixthLabel: UILabel! = UILabel()
	var views: [UIView] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		views += [self.firstButton, self.firstLabel, self.thirdLabel,
				  self.fourthLabel, self.fifthLabel, self.sixthLabel]
		guard let vc = storyboard?.instantiateViewController(withIdentifier: "MenuVC") as? MenuViewController else { return }
		SideMenuManager.shared.sideMenuViewController = vc
		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.show(_:)))
		view.backgroundColor = .white
		SideMenuManager.shared.addScreenEdgeGesture(to: self)
		firstButton.addTarget(self, action: #selector(self.dismissSM(_:)), for: .touchUpInside)
		firstLabel.text = "First Label"
		secondLabel.text = "Second Label"
		thirdLabel.text = "Third Label"
		fourthLabel.text = "Fourth Label"
		fifthLabel.text = "Fifth Label"
		sixthLabel.text = "Sixth Label"
		SideMenuManager.shared.views = views
		
	}
	
	@objc func dismissSM(_ sender: UIButton!) {
		SideMenuManager.shared.dismiss()
	}
	
	@objc func show(_ sender: UITapGestureRecognizer? = nil) {
		SideMenuManager.shared.show(from: self)
	}
}
