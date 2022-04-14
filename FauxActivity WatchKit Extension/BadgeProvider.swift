//
//  BadgeFactory.swift
//  FauxActivity WatchKit Extension
//
//  Created by Spotlight Deveaux on 2022-04-14.
//

import Dynamic
import Foundation

/// A helper class to load badge textures.
class BadgeProvider {
    /// The folder we expect activity achievements to be present in.
    let badgeFolder = Bundle.main.bundlePath + "/ActivityAchievements/3000MoveGoals/"

    /// Loads a badge by the given name, returning its configuration.
    /// This function expects the standard badge layout.
    /// For reference, see /System/Library/Health/Assets/FitnessUIAssets.bundle/ActivityAchievements.
    ///
    /// - Parameter name: The name of the badge to load.
    /// - Returns: A usable AAUIBadgeModelConfiguration with the given badge
    func badge(named name: String) -> Dynamic {
        badge(named: name, model: "badgemodel/BadgeModel.bdg", texture: "badgemodel/BadgeTexture.png", plist: "badgeproperties/BadgeModel.plist")
    }

    /// Loads a badge by the given name, returning its configuration.
    /// This function allows specifying paths reltive to the named achievement path.
    ///
    /// - Parameters:
    ///   - named: The name of the badge to load.
    ///   - modelPath: The path to BadgeModel.bdg, relative to the achievement path.
    ///   - texturePath: The path to BadgeTexture.png, relative to the achievement path.
    ///   - plistPath: The path to BadgeModel.plist, relative to the achievement path.
    func badge(named _: String, model modelPath: String, texture texturePath: String, plist plistPath: String) -> Dynamic {
        Dynamic.AAUIBadgeModelConfiguration.configurationWithModelPath(badgeFolder + modelPath, texturePath: badgeFolder + texturePath, plistPath: badgeFolder + plistPath)
    }
}
