//
//  BadgeView.swift
//  FauxActivity WatchKit Extension
//
//  Created by Spotlight Deveaux on 2022-04-13.
//

import Dynamic
import SwiftUI

#if os(watchOS)
/// Present to allow usage of UIView.
/// A UIView is an NSObject somewhere down the line, at least...
typealias UIView = NSObject

/// Who knew that you could use UIViewRepresentable in watchOS with little fuss?
typealias NativeRepresentable = _UIViewRepresentable
#else
// We need actual UIKit.
import UIKit

typealias NativeRepresentable = UIViewRepresentable
#endif

/// Instantiates a UIView with our badge view.
struct BadgeView: NativeRepresentable {
    typealias UIViewType = UIView

    /// Provider used to obtain badge texture assets.
    let badgeProvider = BadgeProvider()

    func makeUIView(context _: Context) -> UIView {
        // We create a UIView via Dynamic to avoid messing with headers.
        Dynamic.UIView().asAnyObject! as! UIView
    }

    func updateUIView(_ uiView: UIView, context _: Context) {
        // As our UIView is now present, we can add whatever tweaks we'd like to it.
        let object = Dynamic(uiView)

        // We then create a configuration for the given badge.
        // TODO: allow choosing custom badges
        let configuration = badgeProvider.badge(named: "3000MoveGoals")

        // Create our badge view with the given configuration!
        let badgeView = Dynamic.AAUIBadgeView.initUsingEarnedShader(true)
        badgeView.setConfiguration(configuration)

        // We utilize the existing UIView to present our badge view.
        // We remove all other layers from the view and tack it right on.
        object.addSubview(badgeView)
        object.bringSubviewToFront(badgeView)

        // Lastly... a few touch-ups.
        // Derived from [AAUIAchievementFormatter backsideAttributesWithSizeVariant:].
        // Note that no matter whatever attributes are set, a font _must_ be set.
        // FitnessUI's [NSMutableAttributedString(FIUISizing) scaleFontSizeByAmount:minimumFontSize:] will crash otherwise.
        let badgeStyle = NSMutableParagraphStyle()
        badgeStyle.alignment = .center
        badgeStyle.lineHeightMultiple = 0.95

        // This specific color appears to be desired.
        let badgeColor = UIColor(white: 0.5, alpha: 0.5)

        // TODO: Kerning is set - to what?
        let badgeText = NSAttributedString(string: "EARNED BY SPOTLIGHT\nON DECEMBER 21, 2019", attributes: [
            .font: UIFont.boldSystemFont(ofSize: 16.0),
            .foregroundColor: badgeColor,
            .paragraphStyle: badgeStyle,
        ])

        badgeView.setBadgeBacksideAttributedString(badgeText)
        badgeView.setBadgeBacksideIcon(UIImage(systemName: "pawprint.fill"))
    }
}
