//
//  SideMenuAnimatedTransitioning.swift
//  Practice Transition
//
//  Created by Yi-Cheng Lin on 2020/12/3.
//

import Foundation
import UIKit

class SideMenuAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
	var animators: [UIViewPropertyAnimator] = []
	var isInteraction: Bool = false
	var blurView: UIVisualEffectView?
	
	func animate(with fraction: CGFloat) {
		animators.forEach {
			$0.fractionComplete = fraction
		}
	}
	
	func finishAnimate() {
		animators.forEach { $0.continueAnimation(withTimingParameters: nil, durationFactor: 0) }
	}
	
	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return SideMenuManager.shared.configurations.presentationDuration
	}
	
	private func setupBlurView() {
		if blurView == nil {
			let blurEffect = UIBlurEffect(style: .dark)
			let blurview = UIVisualEffectView(effect: blurEffect)
			blurview.frame = UIScreen.main.bounds
			blurview.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismiss(_:))))
			self.blurView = blurview
		}
	}
	
	@objc private func dismiss(_ recognizer: UIGestureRecognizer) {
		SideMenuManager.shared.dismiss()
	}
	
	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		let manager = SideMenuManager.shared
		// 具體動畫實現
		guard
			let fromVC = transitionContext.viewController(forKey: manager.isPresenting ? .to : .from),
			let nvVC = transitionContext.viewController(forKey: manager.isPresenting ? .from : .to) as? SideMenuNavigationViewController,
			let rootVC = nvVC.viewControllers.first as? SideMenuViewControllerProtocol,
			let fromView = fromVC.view else { return }
		
		let containerView = transitionContext.containerView
		containerView.addSubview(nvVC.view)
		
		setupBlurView()
		if let blurView = blurView {
			containerView.insertSubview(blurView, at: 0)
		}
		
		// 轉場動畫初始化
		rootVC.views.forEach {
			$0.alpha = manager.isPresenting ? 1 : 0
			$0.transform = CGAffineTransform(translationX: manager.isPresenting ? 0 : -60, y: 0)
		}
		blurView?.alpha = manager.isPresenting ? 1 : 0
		nvVC.view.alpha = manager.isPresenting ? 1 : 0
		nvVC.view.frame = CGRect(x: 0, y: 0, width: manager.isPresenting ? manager.configurations.menuWidth : 0, height: fromView.frame.height)
		nvVC.view.layoutIfNeeded()
		
		// Animators
		let presentAnimator = UIViewPropertyAnimator(duration: manager.isPresenting ?
														manager.configurations.dismissDuration :
														manager.configurations.presentationDuration,
													 curve: .easeOut,
													 animations: nil)
		
		// SideMenu main view animation
		presentAnimator.addAnimations {
			nvVC.view.alpha = manager.isPresenting ? 0 : 1
			nvVC.view.frame = CGRect(x: 0, y: 0,
									 width: manager.isPresenting ? 0 : manager.configurations.menuWidth,
									 height: fromView.frame.height)
		}
		
		presentAnimator.addAnimations {
			self.blurView?.alpha = manager.isPresenting ? 0 : 1
		}
		
		// SideMenu list items animations
		for (index, view) in rootVC.views.enumerated() {
			presentAnimator.addAnimations({
				view.alpha = manager.isPresenting ? 0 : 1
				view.transform = manager.isPresenting ? CGAffineTransform(translationX: -60, y: 0) : .identity
				nvVC.view.layoutIfNeeded()
			}, delayFactor: CGFloat((Double(index) / Double(rootVC.views.count)) * 0.7 + 0.3))
		}
		
		presentAnimator.addCompletion { _ in transitionContext.completeTransition(true) }
		animators.append(presentAnimator)
		if !isInteraction { presentAnimator.startAnimation() }
	}
	
	// Remove all animators after animation ended.
	func animationEnded(_ transitionCompleted: Bool) {
		animators.removeAll()
	}
}
