//
//  SideMenuNavigationViewController.swift
//  Practice Transition
//
//  Created by Yi-Cheng Lin on 2020/12/2.
//

import UIKit

class SideMenuNavigationViewController: UINavigationController {
	
	private var transitionController: SideMenuTransitionController?
	
	override  var transitioningDelegate: UIViewControllerTransitioningDelegate? {
		get {
			guard transitionController == nil else { return transitionController }
			transitionController = SideMenuTransitionController(config: SideMenuSettings.shared)
			return transitionController
		}

		set {
			
		}
	}
}
