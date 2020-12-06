//
//  SideMenuManager.swift
//  Practice Transition
//
//  Created by Yi-Cheng Lin on 2020/12/5.
//

import UIKit

class SideMenuManager {
	
	static let shared = SideMenuManager()
	
	var configurations: SettingsModel = SideMenuSettingsModel()
	
	private var sideMenuNavigationController: UINavigationController?
	internal var transitionController: SideMenuTransitionController?
	internal var isPresenting: Bool = false
	
	func show(from fromVC: UIViewController, sideMenuViewController: SideMenuViewControllerProtocol & UIViewController, completion: (() -> Void)? = nil) {
		if sideMenuNavigationController == nil {
			sideMenuNavigationController = SideMenuNavigationViewController(rootViewController: sideMenuViewController)
		}
		
		sideMenuNavigationController?.navigationBar.isHidden = true
		sideMenuNavigationController?.modalPresentationStyle = .overFullScreen
		if transitionController == nil {
			transitionController = SideMenuTransitionController()
		}
		sideMenuNavigationController?.transitioningDelegate = transitionController
		fromVC.present(sideMenuNavigationController!, animated: true, completion: { self.isPresenting = true })
	}
	
	func show(from fromVC: UIViewController, views: [UIView], completion: (() -> Void)? = nil) {
		show(from: fromVC, sideMenuViewController: SideMenuViewController(views: views), completion: completion)
	}
	
	func dismiss() {
		sideMenuNavigationController?.dismiss(animated: true, completion: { self.isPresenting = false })
	}
}
