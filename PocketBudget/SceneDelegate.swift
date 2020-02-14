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
        self.window = ApplicationWireframe.shared.initializeWindow(with: windowScene)
    }
}
