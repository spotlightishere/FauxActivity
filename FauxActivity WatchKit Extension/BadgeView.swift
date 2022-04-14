//
//  BadgeView.swift
//  FauxActivity WatchKit Extension
//
//  Created by Spotlight Deveaux on 2022-04-13.
//

import Dynamic
import SwiftUI
import WatchKit

/// Present to allow usage of UIView.
/// A UIView is an NSObject somewhere down the line, at least...
typealias UIView = NSObject

/// Instantiates a UIView.
/// Who knew that you could use UIViewRepresentable in watchOS with little fuss?
struct BadgeView: _UIViewRepresentable {
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

        // Lastly, we utilize the existing UIView to present our badge view.
        // We remove all other layers from the view and tack it right on.
        object.addSubview(badgeView)
        object.bringSubviewToFront(badgeView)
        badgeView.playFlipInAnimation()
    }
}
