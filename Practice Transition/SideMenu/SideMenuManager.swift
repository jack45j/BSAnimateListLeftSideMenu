//
//  SideMenuSettings.swift
//  Practice Transition
//
//  Created by Yi-Cheng Lin on 2020/12/5.
//

import UIKit

protocol AnimationProtocol {
	var views: [UIView] { get }
}

protocol AnimationModel {
	var sideMenuNavigationController: UINavigationController? { get }
	var presentationDuration: TimeInterval { get }
	var dismissDuration: TimeInterval { get }
	var isPresent: Bool { get }
}

class SideMenuSettings: AnimationModel & AnimationProtocol {
	
	static let shared = SideMenuSettings()
	
	var views: [UIView]
	var presentationDuration: TimeInterval
	var dismissDuration: TimeInterval
	var sideMenuNavigationController: UINavigationController?
	var isPresent: Bool = true
	
	init(views: [UIView] = [],
		 presentationDuration: TimeInterval = 0.3,
		 dismissDuration: TimeInterval = 0.3) {
		self.views = views
		self.presentationDuration = presentationDuration
		self.dismissDuration = dismissDuration
	}
	
	func show(from fromVC: UIViewController, views: [UIView], completion: (() -> Void)? = nil) {
		self.views = views
		self.isPresent = true
		if sideMenuNavigationController == nil {
			sideMenuNavigationController = SideMenuNavigationViewController(rootViewController: SideMenuViewController(views: views))
		}
		sideMenuNavigationController?.navigationBar.isHidden = true
		sideMenuNavigationController!.modalPresentationStyle = .overFullScreen
		let transitionController = SideMenuTransitionController(config: self)
		sideMenuNavigationController!.transitioningDelegate = transitionController
		fromVC.present(sideMenuNavigationController!, animated: true, completion: completion)
	}
	
	func dismiss() {
		self.isPresent = false
		sideMenuNavigationController?.dismiss(animated: true, completion: nil)
	}
}
