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
	var transitionController: SideMenuTransitionController? = SideMenuTransitionController()
	var isPresenting: Bool = false
	var currentViewController: UIViewController?
	var views: [UIView]!
	
	func addScreenEdgeGesture(to viewController: UIViewController) {
		let gesture = UIScreenEdgePanGestureRecognizer(target: self,
													   action: #selector(self.handleGesture(_:)))
		gesture.edges = .left
		viewController.view.addGestureRecognizer(gesture)
		if currentViewController != viewController { currentViewController = viewController }
	}
	
	@objc func handleGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
		switch gestureRecognizer.state {
		case .began:
			print("Began")
			show(from: currentViewController!, views: views)
			fallthrough
		case .changed:
			let width = configurations.menuWidth
			let distance = gestureRecognizer.translation(in: gestureRecognizer.view?.superview).x
			let progress = distance / width
			transitionController?.animationController?.fraction = progress
			transitionController?.interactionController?.handle(state: .update(progress: progress))
		case .ended:
			print("End")
		default: return // do nothing
		}
	}
}

extension SideMenuManager {
	func show(from fromVC: UIViewController, sideMenuViewController: SideMenuViewControllerProtocol & UIViewController, completion: (() -> Void)? = nil) {
		if sideMenuNavigationController == nil {
			sideMenuNavigationController = SideMenuNavigationViewController(rootViewController: sideMenuViewController)
		}
		
		sideMenuNavigationController?.navigationBar.isHidden = true
		sideMenuNavigationController?.modalPresentationStyle = .overFullScreen
		sideMenuNavigationController?.transitioningDelegate = transitionController
		
		fromVC.present(sideMenuNavigationController!, animated: true, completion: { self.isPresenting = true })
	}
	
	func show(from fromVC: UIViewController, views: [UIView], completion: (() -> Void)? = nil) {
		show(from: fromVC, sideMenuViewController: SideMenuViewController(views: views), completion: completion)
	}
	
	func show(from fromVC: UIViewController, stackView: UIStackView, completion: (() -> Void)? = nil) {
		show(from: fromVC, views: stackView.arrangedSubviews, completion: completion)
	}
	
	func dismiss() {
		sideMenuNavigationController?.dismiss(animated: true, completion: { self.isPresenting = false })
	}
}
