//
//  SideMenuTransitioningDelegate.swift
//  Practice Transition
//
//  Created by Yi-Cheng Lin on 2020/12/5.
//

import Foundation
import UIKit

class SideMenuTransitionController: NSObject, UIViewControllerTransitioningDelegate {
	
	let config: AnimationModel
	private var animationController: SideMenuAnimatedTransitioning?
	
	func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return animationController
	}
	
	func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return animationController
	}
	
	init(config: AnimationModel) {
		self.config = config
		self.animationController = SideMenuAnimatedTransitioning(config: config)
	}
}
