//
//  AppLauncher.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 16/03/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import UIKit

//
// MARK: APPLICATION LAUNCHER FEATURE
//
class AppLauncher {
    static let shared = AppLauncher()
    lazy var configStorage = ApplicationStorage.config
    lazy var wireframe = ApplicationWireframe.shared
}

//
// MARK: APPLICATION LAUNCHER PUBLIC API
//
extension AppLauncher {
    func start(on windowScene: UIWindowScene) -> UIWindow? {
        var firstModule = ApplicationModule.accountCreationWizard(
            input: AccountCreationWizardModuleInput()
        )
        if configStorage.applicationHasBeenStartedBefore() {
            firstModule = ApplicationModule.monthBalance(
                input: MonthBalanceModuleInput(monthId: "02-2020")
            )
        }
        return wireframe.initializeWindow(on: windowScene, with: firstModule)
    }
}

//
// MARK: PRIVATE FUNCTIONS
//
extension AppLauncher {
    private func applicationHasStartedBefore() -> Bool {
        return true
    }
}
