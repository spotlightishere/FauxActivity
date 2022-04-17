//
//  FauxActivityApp.swift
//  Shared
//
//  Created by Spotlight Deveaux on 2022-04-13.
//

import SwiftUI

@main
struct FauxActivityApp: App {
    init() {
        // Load ActivityAchievementsUI.framework for AAUIBadgeView.
        dlopen("/System/Library/PrivateFrameworks/ActivityAchievementsUI.framework/ActivityAchievementsUI", RTLD_NOW)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
