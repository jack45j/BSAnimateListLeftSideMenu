//
//  SideMenuAnimatedTransitioning.swift
//  Practice Transition
//
//  Created by Yi-Cheng Lin on 2020/12/3.
//

import Foundation
import UIKit



class SideMenuAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
	
	private var config: AnimationModel
	
	init(config: AnimationModel) {
		self.config = config
	}
	
	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return config.presentationDuration
	}
	
	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		// 具體動畫實現
		guard
			let fromVC = transitionContext.viewController(forKey: config.isPresent ? .from : .to),
			let nvVC = transitionContext.viewController(forKey: config.isPresent ? .to : .from) as? SideMenuNavigationViewController,
			let rootVC = nvVC.viewControllers.first as? SideMenuViewController,
			let fromView = fromVC.view else { return }
		
		
		let containerView = transitionContext.containerView
		containerView.addSubview(nvVC.view)
		
		// TODO: 參數設定
		// 轉場動畫初始化
		if config.isPresent {
			rootVC.views.forEach {
				$0.alpha = 0
				$0.transform = CGAffineTransform(translationX: -60, y: 0)
			}
			nvVC.view.alpha = 0
			nvVC.view.frame = CGRect(x: 0, y: 0, width: 0, height: fromView.frame.height)
		} else {
			rootVC.views.forEach {
				$0.alpha = 1
				$0.transform = CGAffineTransform(translationX: 0, y: 0)
			}
			nvVC.view.alpha = 1
			nvVC.view.frame = CGRect(x: 0, y: 0, width: 250, height: fromView.frame.height)
		}
		nvVC.view.layoutIfNeeded()
		
		let presentAnimator = UIViewPropertyAnimator(duration: config.presentationDuration, curve: .easeIn, animations: nil)
		let listAnimator = UIViewPropertyAnimator(duration: config.presentationDuration, curve: .linear, animations: nil)
		
		presentAnimator.addAnimations {
			if self.config.isPresent {
				nvVC.view.alpha = 1
				nvVC.view.frame = CGRect(x: 0, y: 0, width: 250, height: fromView.frame.height)
			} else {
				nvVC.view.alpha = 0
				nvVC.view.frame = CGRect(x: 0, y: 0, width: 0, height: fromView.frame.height)
			}
			
		}
		
		for (index, view) in rootVC.views.enumerated() {
			listAnimator.addAnimations({
				UIViewPropertyAnimator(duration: self.config.presentationDuration, curve: .linear, animations: {
					if self.config.isPresent {
						view.alpha = 1
						view.transform = .identity
						nvVC.view.layoutIfNeeded()
					} else {
						view.alpha = 0
						view.transform = CGAffineTransform(translationX: -60, y: 0)
						nvVC.view.layoutIfNeeded()
					}
				}).startAnimation(afterDelay: Double(index)*0.1)
			})
		}
		
		presentAnimator.addAnimations({
			listAnimator.startAnimation()
		}, delayFactor: 0.5)
		
		
		presentAnimator.addCompletion { _ in transitionContext.completeTransition(true) }
		presentAnimator.startAnimation()
	}
	
	func animationEnded(_ transitionCompleted: Bool) {
//		print("動畫完成")
	}
}
