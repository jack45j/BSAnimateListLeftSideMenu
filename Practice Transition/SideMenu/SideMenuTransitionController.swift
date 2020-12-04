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
	
	func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		
		return SideMenuAnimatedTransitioning(config: config)
	}
	
	func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return SideMenuAnimatedTransitioning(config: config)
	}
	
	init(config: AnimationModel) {
		self.config = config
	}
}
