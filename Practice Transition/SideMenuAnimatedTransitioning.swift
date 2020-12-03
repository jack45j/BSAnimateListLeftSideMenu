//
//  SideMenuAnimatedTransitioning.swift
//  Practice Transition
//
//  Created by Yi-Cheng Lin on 2020/12/3.
//

import Foundation
import UIKit

class SideMenuAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return 5
	}
	
	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		// 具體動畫實現
		guard
			let fromVC = transitionContext.viewController(forKey: .from),
			let nvVC = transitionContext.viewController(forKey: .to) as? SideMenuNavigationViewController,
			let toVC = nvVC.viewControllers.first as? animProtocol,
			let fromView = fromVC.view else { return }
			
		
//		let toView = toVC.view
		
		let containerView = transitionContext.containerView
		
		containerView.addSubview(fromView, nvVC.view)
		
		// 轉場動畫
		toVC.views.forEach {
			$0.alpha = 0
			$0.transform = CGAffineTransform(translationX: -60, y: 0)
		}
		nvVC.view.alpha = 0
		nvVC.view.frame = CGRect(x: 0, y: 0, width: 0, height: fromView.frame.height)
		UIView.animate(withDuration: 0.5,
					   delay: 0,
					   options: [.curveLinear], animations: {
						fromView.alpha = 0.6
						nvVC.view.alpha = 1
						nvVC.view.frame = CGRect(x: 0, y: 0, width: 220, height: fromView.frame.height)
						nvVC.view.layer.shadowColor = UIColor.black.cgColor
						nvVC.view.layer.shadowOffset = .init(width: 5, height: 5)
						nvVC.view.layer.shadowOpacity = 1
						
						for (index, view) in toVC.views.enumerated() {
							UIView.animate(withDuration: 0.3,
										   delay: Double(index) / 10,
										   animations: {
											view.alpha = 1
											view.transform = CGAffineTransform(translationX: 0, y: 0)
										   })
						}
		}, completion: { finished in
			
			// 通知完成轉場
			transitionContext.completeTransition(true)
		})
	}
	
	func animationEnded(_ transitionCompleted: Bool) {
		print("動畫完成")
	}
}
