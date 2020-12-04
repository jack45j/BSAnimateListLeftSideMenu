//
//  ViewController.swift
//  Practice Transition
//
//  Created by Yi-Cheng Lin on 2020/12/2.
//

import UIKit

class ViewController: UIViewController {

	let firstButton: UIButton! = UIButton(type: .infoDark)
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
		
		view.backgroundColor = .yellow
		let tap = UITapGestureRecognizer(target: self, action: #selector(self.show(_:)))
		view.addGestureRecognizer(tap)
		firstButton.addAction(UIAction(handler: { _ in SideMenuSettings.shared.dismiss() }), for: .touchUpInside)
		firstLabel.text = "First Label"
		secondLabel.text = "Second Label"
		thirdLabel.text = "Third Label"
		fourthLabel.text = "Fourth Label"
		fifthLabel.text = "Fifth Label"
		sixthLabel.text = "Sixth Label"
	}
	
	@objc func show(_ sender: UITapGestureRecognizer? = nil) {
		SideMenuSettings.shared.show(from: self, views: views)
	}
}
