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
		setupUI()
		views += [self.firstButton, self.firstLabel, self.thirdLabel,
				  self.fourthLabel, self.fifthLabel, self.sixthLabel]
		guard let vc = storyboard?.instantiateViewController(withIdentifier: "MenuVC") as? MenuViewController else { return }
		SideMenuManager.shared.sideMenuViewController = vc
		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.show(_:)))
		SideMenuManager.shared.addScreenEdgeGesture(to: self)
		SideMenuManager.shared.views = views
	}
	
	func setupUI() {
		title = "BSLeftSideMenu"
		view.backgroundColor = .white
		navigationController?.navigationBar.tintColor = .black
		navigationController?.navigationBar.isTranslucent = false
		
		firstButton.addTarget(self, action: #selector(self.dismissSM(_:)), for: .touchUpInside)
		firstLabel.text = "First Label"
		secondLabel.text = "Second Label"
		thirdLabel.text = "Third Label"
		fourthLabel.text = "Fourth Label"
		fifthLabel.text = "Fifth Label"
		sixthLabel.text = "Sixth Label"
		
		firstLabel.textColor = .black
		secondLabel.textColor = .black
		thirdLabel.textColor = .black
		fourthLabel.textColor = .black
		fifthLabel.textColor = .black
		sixthLabel.textColor = .black
	}
	
	@objc func dismissSM(_ sender: UIButton!) {
		SideMenuManager.shared.dismiss()
	}
	
	@objc func show(_ sender: UITapGestureRecognizer? = nil) {
		SideMenuManager.shared.show(from: self)
	}
}
