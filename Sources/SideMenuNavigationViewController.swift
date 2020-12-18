//
//  SideMenuNavigationViewController.swift
//  Practice Transition
//
//  Created by Yi-Cheng Lin on 2020/12/2.
//

import UIKit

class SideMenuNavigationViewController: UINavigationController {
	override var transitioningDelegate: UIViewControllerTransitioningDelegate? {
		get { SideMenuManager.shared.transitionController }
		set {}
	}
}
