//
//  SideMenuSettings.swift
//  Practice Transition
//
//  Created by Yi-Cheng Lin on 2020/12/6.
//

import Foundation
import UIKit

public protocol SideMenuViewControllerProtocol {
	var views: [UIView] { get set }
}

public protocol SideMenuAnimationSettings {
	var presentationDuration: TimeInterval { get set }
	var dismissDuration: TimeInterval { get set }
}

public protocol SideMenuSettings {
	var menuWidth: CGFloat { get }
	var menuWidthInScreenScale: CGFloat { get set }
	var maxMenuWidth: CGFloat { get set}
}

public typealias SettingsModel = SideMenuAnimationSettings & SideMenuSettings
struct SideMenuSettingsModel: SettingsModel {
	var menuWidthInScreenScale: CGFloat = 0.5
	var maxMenuWidth: CGFloat = 240
	var menuWidth: CGFloat {
		get {
			let screenWidth = UIScreen.main.bounds.width
			return min(screenWidth * menuWidthInScreenScale, maxMenuWidth)
		}
	}
	var presentationDuration: TimeInterval = 0.5
	var dismissDuration: TimeInterval = 0.3
}
