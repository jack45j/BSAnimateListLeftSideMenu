//
//  SideMenuManager.swift
//  Practice Transition
//
//  Created by Yi-Cheng Lin on 2020/12/5.
//

import UIKit

public final class SideMenuManager {
	
	public static let shared = SideMenuManager()
	public var configurations: SettingsModel = SideMenuSettingsModel()
	
	public var sideMenuViewController: (SideMenuViewControllerProtocol & UIViewController)?
	private var sideMenuNavigationController: UINavigationController?
	var transitionController: SideMenuTransitionController? = SideMenuTransitionController()
	var isPresenting: Bool = false
	private var currentViewController: UIViewController?
	var views: [UIView] = []
}

// MARK: Gesture
extension SideMenuManager {
	public func addScreenEdgeGesture(to viewController: UIViewController) {
		let gesture = UIScreenEdgePanGestureRecognizer(target: self,
													   action: #selector(self.handleGesture(_:)))
		gesture.edges = .left
		viewController.view.addGestureRecognizer(gesture)
		if currentViewController != viewController { currentViewController = viewController }
	}
	
	@objc private func handleGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
		switch gestureRecognizer.state {
		case .began:
			show(from: currentViewController!, views: views)
			transitionController?.animationController?.isInteraction = true
			fallthrough
		case .changed:
			let width = configurations.menuWidth
			let distance = gestureRecognizer.translation(in: gestureRecognizer.view?.superview).x
			let progress = distance / width
			transitionController?.animationController?.animate(with: progress)
		case .ended:
			let width = configurations.menuWidth
			let distance = gestureRecognizer.translation(in: gestureRecognizer.view?.superview).x
			let progress = distance / width
			transitionController?.animationController?.finishAnimate(isReversed: progress < 0.5)
			if progress < 0.5 {
				sideMenuNavigationController?.dismiss(animated: false, completion: { self.isPresenting = false })
			}
			transitionController?.animationController?.isInteraction = false
		default: return
		}
	}
}

// MARK: show/dismiss
public extension SideMenuManager {
	func show(from fromVC: UIViewController, interaction: Bool = false, completion: (() -> Void)? = nil) {
		if sideMenuViewController == nil {
			guard !views.isEmpty else {
				print("You have to set SideMenuViewController or list views first.")
				return
			}
			sideMenuViewController = SideMenuViewController(views: views)
		}
		if sideMenuNavigationController == nil {
			sideMenuNavigationController = SideMenuNavigationViewController(rootViewController: sideMenuViewController!)
		}
		
		sideMenuNavigationController?.navigationBar.isHidden = true
		sideMenuNavigationController?.modalPresentationStyle = .overFullScreen
		sideMenuNavigationController?.transitioningDelegate = transitionController
		transitionController?.animationController?.isInteraction = false
		fromVC.present(sideMenuNavigationController!, animated: true, completion: { self.isPresenting = true })
	}
	
	func show(from fromVC: UIViewController, views: [UIView], interaction: Bool = false, completion: (() -> Void)? = nil) {
		show(from: fromVC, completion: completion)
	}
	
	private func show(from fromVC: UIViewController, stackView: UIStackView, interaction: Bool = false, completion: (() -> Void)? = nil) {
		show(from: fromVC, views: stackView.arrangedSubviews, completion: completion)
	}
	
	func dismiss() {
		transitionController?.animationController?.isInteraction = false
		sideMenuNavigationController?.dismiss(animated: true, completion: { self.isPresenting = false })
	}
}
