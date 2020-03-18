//
//  SceneDelegate.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 14/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        applyGlobalStyles()
        window = AppLauncher.shared.start(on: windowScene)
    }
}

extension SceneDelegate {
    func applyGlobalStyles() {
        guard
            let headlineFont = AppFont.font(fromStyle: .headline),
            let bodyFont = AppFont.font(fromStyle: .body)
        else { return }
        let headlineFontTextAttributes = [NSAttributedString.Key.font: headlineFont]
        let bodyFontTextAttributes = [NSAttributedString.Key.font: bodyFont]
        UINavigationBar.appearance().titleTextAttributes = headlineFontTextAttributes
        UIBarButtonItem.appearance().setTitleTextAttributes(bodyFontTextAttributes, for: .normal)
        TextField.appearance().font = bodyFont
    }
}
