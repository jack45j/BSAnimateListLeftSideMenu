//
//  SideMenuViewController.swift
//  Practice Transition
//
//  Created by Yi-Cheng Lin on 2020/12/2.
//

import UIKit

class SideMenuViewController: UIViewController, SideMenuViewControllerProtocol {
	var stackView: UIStackView!
	var views: [UIView] = []
//	let sideMenu = SideMenuManager.shared.sideMenuViewController
	
	init(views: [UIView]) {
		self.views = views
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .white
		
		stackView = UIStackView(arrangedSubviews: views)
		stackView.alignment = .leading
		stackView.axis = .vertical
		stackView.distribution = .fill
		stackView.spacing = 24
		
		view.addSubview(stackView)
		
		stackView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint(item: stackView!, attribute: .bottom, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: -24).isActive = true
		NSLayoutConstraint(item: stackView!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -60).isActive = true
		view.layoutIfNeeded()
    }
}
