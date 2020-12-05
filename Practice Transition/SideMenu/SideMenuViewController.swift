//
//  SideMenuViewController.swift
//  Practice Transition
//
//  Created by Yi-Cheng Lin on 2020/12/2.
//

import UIKit
import SnapKit

class SideMenuViewController: UIViewController, AnimationProtocol {
	var stackView: UIStackView!
	var views: [UIView] = []
	
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
		
		stackView.snp.makeConstraints({ constraint in
			constraint.bottom.equalTo(view.safeAreaLayoutGuide).inset(24)
//			constraint.leading.greaterThanOrEqualTo(view).offset(20)
			constraint.trailing.equalTo(view).inset(60)
			constraint.height.greaterThanOrEqualTo(0)
		})
		view.layoutIfNeeded()
    }
}
