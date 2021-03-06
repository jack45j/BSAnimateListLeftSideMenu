//
//  SideMenuTransitioningDelegate.swift
//  Practice Transition
//
//  Created by Yi-Cheng Lin on 2020/12/5.
//

import Foundation
import UIKit

class SideMenuTransitionController: NSObject, UIViewControllerTransitioningDelegate {
	
	var animationController: SideMenuAnimatedTransitioning? = SideMenuAnimatedTransitioning()
	
	func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return animationController
	}
	
	func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return animationController
	}
	
	func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
		return UIPercentDrivenInteractiveTransition()
	}
	
	func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
		return UIPercentDrivenInteractiveTransition()
	}
}
