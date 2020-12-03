//
//  SideMenuViewController.swift
//  Practice Transition
//
//  Created by Yi-Cheng Lin on 2020/12/2.
//

import UIKit
import SnapKit

protocol animProtocol {
	var firstButton: UIButton! { get }
	var firstLabel: UILabel! { get }
	var secondLabel: UILabel! { get }
	var thirdLabel: UILabel! { get }
	var fourthLabel: UILabel! { get }
	var fifthLabel: UILabel! { get }
	var sixthLabel: UILabel! { get }
	var view: UIView! { get }
	var stackView: UIStackView! { get }
	var views: [UIView] { get}
}

class SideMenuViewController: UIViewController, animProtocol {
	var firstButton: UIButton! = UIButton(type: .infoDark)
	var firstLabel: UILabel! = UILabel()
	var secondLabel: UILabel! = UILabel()
	var thirdLabel: UILabel! = UILabel()
	var fourthLabel: UILabel! = UILabel()
	var fifthLabel: UILabel! = UILabel()
	var sixthLabel: UILabel! = UILabel()
	var stackView: UIStackView!
	var views: [UIView] = []
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .white
		firstButton.addAction(UIAction(handler: { _ in print("Tap") }), for: .touchUpInside)
		firstLabel.text = "First Label"
		secondLabel.text = "Second Label"
		thirdLabel.text = "Third Label"
		fourthLabel.text = "Fourth Label"
		fifthLabel.text = "Fifth Label"
		sixthLabel.text = "Sixth Label"
		views += [firstButton, firstLabel, secondLabel, thirdLabel, fourthLabel, fifthLabel, sixthLabel]
		stackView = UIStackView(arrangedSubviews: views)
		stackView.alignment = .leading
		stackView.axis = .vertical
		stackView.distribution = .fill
		stackView.spacing = 24
		
		view.addSubview(stackView)
		
		stackView.snp.makeConstraints({ constraint in
			constraint.bottom.equalTo(view.safeAreaLayoutGuide).inset(24)
//			constraint.leading.equalTo(view).offset(20)
			constraint.trailing.equalTo(view).inset(60)
			constraint.height.greaterThanOrEqualTo(0)
		})
    }
}
