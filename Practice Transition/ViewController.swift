//
//  ViewController.swift
//  Practice Transition
//
//  Created by Yi-Cheng Lin on 2020/12/2.
//

import UIKit

class ViewController: UIViewController, UIViewControllerTransitioningDelegate {

	func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return SideMenuAnimatedTransitioning()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
			let navigation = SideMenuNavigationViewController(rootViewController: SideMenuViewController())
			navigation.modalPresentationStyle = .custom
			navigation.modalTransitionStyle = .crossDissolve
			navigation.transitioningDelegate = self
			self.present(navigation, animated: true, completion: nil)
		})
	}
}
