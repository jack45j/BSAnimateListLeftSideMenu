//
//  SideMenuSettings.swift
//  Practice Transition
//
//  Created by Yi-Cheng Lin on 2020/12/6.
//

import Foundation
import UIKit

protocol SideMenuViewControllerProtocol {
	var views: [UIView] { get set }
}

protocol SideMenuAnimationSettings {
	var presentationDuration: TimeInterval { get set }
	var dismissDuration: TimeInterval { get set }
}

protocol SideMenuSettings {
	var menuWidth: CGFloat { get set }
}

typealias SettingsModel = SideMenuAnimationSettings & SideMenuSettings
struct SideMenuSettingsModel: SettingsModel {
	var menuWidth: CGFloat = {
		let screenWidth = UIScreen.main.bounds.width
		return min(screenWidth * 0.5, 240)
	}()
	var presentationDuration: TimeInterval = 0.3
	var dismissDuration: TimeInterval = 0.3
}
